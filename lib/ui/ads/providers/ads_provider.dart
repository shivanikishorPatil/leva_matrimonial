import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/ad.dart';

import '../../../repositories/ad_repository_provider.dart';

final adsProvider = StreamProvider<List<Ad>>(
  (ref) => ref.read(adsRepositoryProvider).adsStream,
);
