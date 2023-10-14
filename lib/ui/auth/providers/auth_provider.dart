import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../providers/loading_provider.dart';
//auth provider
final authProvider = ChangeNotifierProvider((ref) => Auth(ref));
//auth notifier
class Auth extends ChangeNotifier {
  final Ref _ref;
  Auth(this._ref);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userStream => _auth.authStateChanges();

  String _countryCode = '+91';
  String get countryCode => _countryCode;
  set countryCode(String countryCode) {
    _countryCode = countryCode;
    notifyListeners();
  }

  String? _verificationId;
  String? get verificationId => _verificationId;
  set verificationId(String? verificationId) {
    _verificationId = verificationId;
    notifyListeners();
  }

  String _phone = '';
  String get phone => _phone;
  set phone(String phone) {
    _phone = phone;
    _code = '';
    resendToken = null;
    notifyListeners();
  }

  String _code = '';
  String get code => _code;
  set code(String code) {
    _code = code;
    notifyListeners();
  }

  int? resendToken;

  Loading get _loading => _ref.read(loadingProvider);

  late Stream<int> stream;

  Stream<int> get _stream =>
      Stream.periodic(const Duration(seconds: 1), (v) => 30 - v);
  //method to send opt on countrycode+phone
  void sendOTP(
      {required Function(String) onError,
      required Function(String) onMessage}) async {
    _loading.start();
    try {
      await _auth.verifyPhoneNumber(
        forceResendingToken: resendToken,
        phoneNumber: "$countryCode$phone",
        verificationCompleted: (PhoneAuthCredential credential) async {
          _loading.start();
          try {
            await _manageCredential(credential);
          } catch (e) {
            onError("$e");
          }
          _loading.end();
          verificationId = null;
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            onError("The provided phone number is not valid.");
          } else {
            debugPrint(e.message);
            onError(e.code);
          }
          _loading.stop();
        },
        timeout: const Duration(seconds: 30),
        codeAutoRetrievalTimeout: (_) {},
        codeSent: (String id, int? forceResendingToken) {
          verificationId = id;
          stream = _stream;
          debugPrint(forceResendingToken.toString());
          if (resendToken != null) {
            onMessage("Resent OTP!");
          }
          notifyListeners();
          resendToken = forceResendingToken;
          _loading.stop();
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _loading.stop();
    }
  }
  //method to signin after verify otp
  Future<void> _manageCredential(AuthCredential credential) async {
    await _auth.signInWithCredential(credential);
  }
  //method to verify otp
  Future<void> verifyOTP({required VoidCallback clear}) async {
    _loading.start();
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: code,
      );
      await _manageCredential(credential);
      phone = '';
      verificationId = null;
      _loading.end();
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      _loading.stop();
      clear();
      if (e.code == 'invalid-verification-code') {
        return Future.error("Invalid OTP!");
      } else {
        return Future.error(e.code);
      }
    } catch (e) {
      _loading.stop();
      if (kDebugMode) {
        print(e);
      }
    }
  }
  //singout method
  Future<void> signOut() async {
    await _auth.signOut();
  }
  //phone number formatter for validation
  final formater = MaskTextInputFormatter(
    mask: '##########',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );
  //otp formatter
  final codeformater = MaskTextInputFormatter(
    mask: '#   #   #   #   #   #',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
