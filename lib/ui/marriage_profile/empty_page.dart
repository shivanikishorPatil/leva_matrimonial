import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/auth/providers/auth_provider.dart';
import 'package:leva_matrimonial/ui/components/big_button.dart';
import 'package:leva_matrimonial/ui/marriage_profile/providers/write_marriage_profile_provider.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_personal_details_page.dart';
import 'package:leva_matrimonial/utils/labels.dart';

import '../../utils/assets.dart';

class EmptyPage extends ConsumerWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
        child: BigButton(
          label: "CONTINUE",
          onPressed: () {
            ref.refresh(writeMarriageProfileProvider);
            Navigator.pushNamed(context, WritePersonalDetailsPage.route);
          },
        ),
      ),
      appBar: AppBar(
        title: Text(Labels.appName),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider).signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(Assets.note1),
          ),
          // Text(
          //   "1.  फॉर्म (बहुतांश) मराठीत भरायचा आहे.\n\n"
          //   "2. मराठी सुलभतेने भरण्यासाठी keyboard (abc-->मराठी) वापरावा.\n\n"
          //   "3. कोणत्याही मदतीसाठी संपर्क करा संपर्क: 8055517377, 8055567377\n\n"
          //   "लेवा नवयुवक संघ, जळगाव",
          //   style: style.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          // ),
        ),
      ),
    );
  }
}
