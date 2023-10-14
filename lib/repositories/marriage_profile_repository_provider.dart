import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/utils/dates.dart';
import '../../utils/constants.dart';

final marriageProfileRepositoryProvider =
    Provider((ref) => MarriageProfileRepository());

class MarriageProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> write(MarriageProfile profile,
      {File? file, File? thumbnail}) async {
    String? image;
    String? thumbnailImage;
    if (file != null && thumbnail != null) {
      image = await uploadImage(file);
      thumbnailImage = await uploadImage(thumbnail);
    }
    await _firestore.collection(Constants.profiles).doc(profile.id).set(
          profile
              .copyWith(image: image, thumbnail: thumbnailImage, only: true)
              .toMap(),
          SetOptions(merge: true),
        );
  }

  Future<void> updateMarriageProfile(MarriageProfile marriageProfile) async {
    await _firestore
        .collection(Constants.profiles)
        .doc(marriageProfile.id)
        .set(marriageProfile.toMap());
  }

  Future<String> uploadImage(File file) async {
    return await (await _storage
            .ref(Constants.profiles)
            .child("${DateTime.now().microsecondsSinceEpoch}")
            .putFile(file))
        .ref
        .getDownloadURL();
  }

  Stream<MarriageProfile> streamProfile(String uid) =>
      _firestore.collection(Constants.profiles).doc(uid).snapshots().map(
        (event) {
          if (event.exists) {
            return MarriageProfile.fromFirestore(event);
          } else {
            throw "data-not-exists";
          }
        },
      );

  Stream<List<MarriageProfile>> streamProfiles({required Gender gender}) {
    return _firestore
        .collection(Constants.profiles)
        .where("gender", isEqualTo: gender.name)
        .where(
          "updatedAt",
          isGreaterThan: DateTime.now(),
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => MarriageProfile.fromFirestore(e),
              )
              .toList(),
        );
  }

  Future<List<DocumentSnapshot>> paginateProfiles({
    required int limit,
    DocumentSnapshot? lastDocument,
    required Gender gender,
    required String key,
    String? eduCategory,
    int? heightRange,
    int? maxAge,
    int? minAge,
    int? maxSalary,
    int? minSalary,
    required Status status,
  }) async {
    var docRef = _firestore
        .collection('profiles')
        .where("gender", isEqualTo: gender.name)
        .where(
          "status",
          isEqualTo: status.name,
        );
    if (eduCategory != null) {
      docRef = docRef.where("eduCategory", isEqualTo: eduCategory);
    }
    if (heightRange != null) {
      docRef = docRef.where("hr", isEqualTo: heightRange);
    }
    if (key.isNotEmpty) {
      docRef = docRef.where("keys", arrayContains: key);
    }
    if (maxSalary != null && minSalary != null) {
      docRef = docRef
          .where('salary',
              isLessThanOrEqualTo: maxSalary, isGreaterThanOrEqualTo: minSalary)
          .orderBy("salary");
    } else if (minAge != null && maxAge != null) {
      final minBirth = DateTime(
          Dates.today.year - maxAge, Dates.today.month, Dates.today.day);
      final maxBirth = DateTime(
          Dates.today.year - minAge, Dates.today.month, Dates.today.day);

      docRef = docRef
          .where("birth",
              isGreaterThanOrEqualTo: minBirth, isLessThanOrEqualTo: maxBirth)
          .orderBy("birth");
    }
    if (lastDocument != null) {
      docRef = docRef.startAfterDocument(lastDocument);
    }

    return docRef.limit(limit).get().then((value) => value.docs);
  }

  void submit(String id, {required String name}) {
    _firestore.collection(Constants.profiles).doc(id).update(
      {
        "status": Status.pending.name,
        "filledBy": name,
      },
    );
  }

  void update(
      {required Status status, required String id, required int number}) {
    print("uyabsdiabsdiabsdasbdb $number");
    _firestore.collection(Constants.profiles).doc(id).update(
      {"status": status.name, "updatedAt": Timestamp.now(), "regNo": number},
    );
  }

  Future<int> getNumberOfApprovedProfiles(Gender gender) async {
    return await _firestore
        .collection(Constants.profiles)
        .where('status', isEqualTo: Status.approved.name)
        .where('gender', isEqualTo: gender.name)
        .get()
        .then((value) => value.docs.length);
  }
}
