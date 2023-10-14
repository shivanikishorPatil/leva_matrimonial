import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/profile.dart';
import '../../../repositories/profile_repository_provider.dart';
import '../../auth/providers/user_provider.dart';
import '../../providers/loading_provider.dart';
import 'profile_provider.dart';

final writeProfileProvider =
    ChangeNotifierProvider((ref) => WriteProfileNotifier(ref.read));

class WriteProfileNotifier extends ChangeNotifier {
  final  _reader;
  WriteProfileNotifier(this._reader);

  User get _user => _reader(userProvider).value!;

  bool get edit => _initial != null;

  Profile? get _initial => _reader(profileProvider).asData?.value;

  Profile get profile =>
      _initial ??
      Profile.empty().copyWith(
        id: _user.uid,
        phone: _user.phoneNumber,
      );



  String? _email;
  String get email => _email ?? profile.email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  bool get enabled => email.isNotEmpty;

  Loading get _loading => _reader(loadingProvider);

  Future<void> writeProfile() async {
    final updated = profile.copyWith(
      id: _user.uid,
      email: email,
    );
    _loading.start();
    try {
      await _reader(profileRepositoryProvider).write(updated);
    } catch (e) {
      _loading.stop();
      return Future.error("$e");
    }
    _loading.stop();
  }

  void clear() {

  }
}
