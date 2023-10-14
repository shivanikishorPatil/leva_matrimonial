import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';
import 'package:leva_matrimonial/ui/profile/providers/profile_provider.dart';

final marriageProfileProvider = StreamProvider<MarriageProfile>(
  (ref) {
    final id =
        ref.watch(profileProvider.select((value) => value.asData?.value.id));
    if (id == null) {
      return Stream.error("error!");
    } else {
      final role = ref.read(profileProvider).value!.role;
      if (role == Role.admin) {
        return Stream.error("admin");
      }
      return ref.read(marriageProfileRepositoryProvider).streamProfile(id);
    }
  },
);
