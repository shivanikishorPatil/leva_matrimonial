import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';

import '../../../enums/gender.dart';

final profilesProvider = StreamProvider.family<List<MarriageProfile>, Gender>(
  (ref, param) => ref.read(marriageProfileRepositoryProvider).streamProfiles(
        gender: param,
      ),
);
