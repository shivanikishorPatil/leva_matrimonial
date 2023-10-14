import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';

final profileCardNotifier =
    ChangeNotifierProvider((ref) => ProfileCardNotifier(ref));

class ProfileCardNotifier extends ChangeNotifier {
  final Ref ref;
  ProfileCardNotifier(this.ref);

  MarriageProfileRepository get marraiageProfileRepo =>
      ref.watch(marriageProfileRepositoryProvider);
  Status status = Status.pending;

  Future<void> changeStatus(MarriageProfile marriageProfile) async {
    try {
      // var _marriageProfile = marriageProfile.copyWith(status: status);
      // print(_marriageProfile.status.toString());
      marraiageProfileRepo
          .updateMarriageProfile(marriageProfile.copyWith(status: status));
    } catch (e) {
      print('chanegStatus$e');
    }
  }
}
