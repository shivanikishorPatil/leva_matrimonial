import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/profile.dart';
import '../../../repositories/profile_repository_provider.dart';
import '../../auth/providers/user_provider.dart';

final profileProvider = StreamProvider<Profile>(
  (ref) {
    final id =
        ref.watch(userProvider.select((value) => value.asData?.value?.uid));
    if (id == null) {
      return Stream.error("error!");
    } else {
      return ref.read(profileRepositoryProvider).streamProfile(id);
    }
  },
);

final profileFutureProvider = FutureProvider.family<Profile, String>(
  (ref, id) => ref.read(profileRepositoryProvider).futureProfile(id),
);
