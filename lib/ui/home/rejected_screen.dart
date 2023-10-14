import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/home/widgets/drawer.dart';

import '../../models/marriage_profile.dart';
import '../../models/profile.dart';
import '../auth/providers/auth_provider.dart';
import '../components/logout_button.dart';
import '../marriage_profile/details_page.dart';

class RejectedScreen extends ConsumerWidget {
  final MarriageProfile mProfile;
  final Profile profile;
  const RejectedScreen(
      {Key? key, required this.mProfile, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: AppDrawer(profile: profile),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, DetailsPage.route,
                    arguments: mProfile);
              },
              icon: const Icon(Icons.person)),
          const LogoutButton()
        ],
      ),
      body: const Center(
          child: Text('Your Application has been rejected by Admin')),
    );
  }
}
