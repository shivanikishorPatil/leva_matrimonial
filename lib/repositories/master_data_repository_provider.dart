import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/master_data.dart';

//future provider to get app version data from firebase
final getAppVersionFutureProvider = FutureProvider<AppVersion>(
    (ref) => ref.watch(masterDataProvider).getVersion());

//get method to get master data from firestore
final masterDataProvider = Provider((ref) => MasterDataProvider());

class MasterDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //get method for app version
  Future<AppVersion> getVersion() async {
    return await _firestore
        .collection('masterData')
        .doc('appVersion')
        .get()
        .then((value) => AppVersion.fromMap(value.data()!));
  }
}
