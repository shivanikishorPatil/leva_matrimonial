import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/loading_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/providers/marriage_profile_provider.dart';

class DetailsRoot extends ConsumerWidget {
  const DetailsRoot({Key? key}) : super(key: key);
  static const route = "/rootDetails";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(marriageProfileProvider).when(
          data: (data) => DetailsPage(mProfile: data),
          error: (e, s) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text("$e"),
            ),
          ),
          loading: () => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
