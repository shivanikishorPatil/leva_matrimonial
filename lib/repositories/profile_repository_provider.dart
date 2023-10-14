import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/profile.dart';
import '../../utils/constants.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository());

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> write(Profile profile
      // , {File? file}
      ) async {
    // String? image;
    // if (file != null) {
    //   image = await uploadImage(file);
    // }
    await _firestore.collection(Constants.users).doc(profile.id).set(
          profile.toMap(),
          SetOptions(merge: true),
        );
  }

  Future<String> uploadImage(File file) async {
    return await (await _storage
            .ref(Constants.users)
            .child("${DateTime.now().microsecondsSinceEpoch}")
            .putFile(file))
        .ref
        .getDownloadURL();
  }

  Stream<Profile> streamProfile(String uid) =>
      _firestore.collection(Constants.users).doc(uid).snapshots().map(
            (event) => Profile.fromFirestore(event),
          );

  Future<Profile> futureProfile(String uid) =>
      _firestore.collection(Constants.users).doc(uid).get().then(
            (event) => Profile.fromFirestore(event),
          );

  Stream<List<Profile>> getAdmins() => _firestore
      .collection(Constants.users)
      .where('role', isEqualTo: 'admin')
      .snapshots()
      .map((event) => event.docs.map((e) => Profile.fromFirestore(e)).toList());
}
