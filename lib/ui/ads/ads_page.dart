import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/ui/ads/providers/ads_provider.dart';
import 'package:leva_matrimonial/ui/ads/providers/write_ad_view_model_provider.dart';
import 'package:leva_matrimonial/ui/ads/write_ad_page.dart';
import 'package:leva_matrimonial/utils/labels.dart';

import '../profile/providers/profile_provider.dart';
import 'widgets/ad_card.dart';

class AdsPage extends ConsumerWidget {
  const AdsPage({Key? key}) : super(key: key);
  static const route = "/ads";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(profileProvider).value!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(Labels.advertisements),
      ),
      floatingActionButton: profile.role==Role.admin? FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, WriteAdPage.route);
          ref.read(writeAdViewModelProvider).clear();
        },
        child: const Icon(Icons.add),
      ):null,
      body: ref.watch(adsProvider).when(
            data: (ads) => ListView(
              padding: const EdgeInsets.all(4),
              children: ads
                  .map(
                    (e) => AdCard(e: e,editable: profile.role==Role.admin,),
                  )
                  .toList(),
            ),
            error: (e, s) => Center(
              child: Text("$e"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
