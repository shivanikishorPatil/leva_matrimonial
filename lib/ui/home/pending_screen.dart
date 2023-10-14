import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/models/profile.dart';
import 'package:leva_matrimonial/ui/components/logout_button.dart';
import 'package:leva_matrimonial/ui/home/widgets/drawer.dart';
import 'package:leva_matrimonial/utils/labels.dart';

import '../../utils/assets.dart';
import '../marriage_profile/details_page.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({Key? key, required this.profile, required this.mProfile})
      : super(key: key);
  final MarriageProfile mProfile;
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Scaffold(
      drawer: AppDrawer(
        profile: profile,
      ),
      appBar: AppBar(
        title: const Text(Labels.appName),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Form Status: ${mProfile.status.name.toUpperCase()}\n',
                style: style.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: mProfile.status == Status.approved
                        ? Colors.green.shade700
                        : mProfile.status == Status.rejected
                            ? Colors.red.shade700
                            : Colors.yellow.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(Assets.note2),
              ),
//                   Text(
//                 """आपला वधु-वर सूची 2022 फॉर्म मिळाला आहे.हा फॉर्म दोन दिवसात मंजूर (Approve) करण्यात येईल.

// आपला फॉर्म मंजूर झाल्यावर आपण भरलेल्या फॉर्म ची PDF प्रत डाऊनलोड करता येईल.

// 1 ऑक्टोबर 2022 पासून आपण याच ॲप मध्ये वधु-वर profile browsing करू शकाल.

// संपर्क: 80 555 17 377, 80 555 67 377
// लेवा नवयुवक संघ
// """,
//                 style: style.titleLarge!
//                     .copyWith(fontWeight: FontWeight.w800, fontSize: 20),
//                 textAlign: TextAlign.start,
//               ),
            ),
            mProfile.status == Status.rejected
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, DetailsPage.route,
                          arguments: mProfile);
                    },
                    child: const Text('Edit Profile'))
                : const SizedBox(),
            mProfile.status == Status.approved
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Form Number: ${mProfile.regNo}\n',
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
