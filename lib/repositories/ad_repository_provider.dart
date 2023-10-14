import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/ad.dart';

final adsRepositoryProvider = Provider((ref) => AdRepository());

class AdRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> writeItem(Ad ad, {File? file}) async {
    final ref = _firestore.collection("ads").doc(ad.id.isEmpty ? null : ad.id);
    final String? imageUrl = file != null
        ? await (await _storage.ref("ads").child(ref.id).putFile(file))
            .ref
            .getDownloadURL()
        : null;

    await ref.set(
      ad.copyWith(image: imageUrl).toMap(),
      SetOptions(merge: true),
    );
  }

  Stream<List<Ad>> get adsStream => _firestore
      .collection('ads')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (e) => Ad.fromFirestore(e),
            )
            .toList(),
      );

  void delete(String id) {
    _firestore.collection("ads").doc(id).delete();
  }
}
