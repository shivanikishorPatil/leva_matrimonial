import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/repositories/master_data_repository_provider.dart';
import 'package:leva_matrimonial/ui/home/pending_screen.dart';
import 'package:leva_matrimonial/ui/home/rejected_screen.dart';
import 'package:leva_matrimonial/ui/marriage_profile/details_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/empty_page.dart';
import 'package:leva_matrimonial/ui/marriage_profile/providers/marriage_profile_provider.dart';
import 'package:leva_matrimonial/ui/providers/loading_provider.dart';
import 'package:leva_matrimonial/utils/app_version.dart';
import 'package:leva_matrimonial/utils/constants.dart';

import 'auth/login_page.dart';
import 'auth/providers/auth_provider.dart';
import 'auth/providers/user_provider.dart';
import 'auth/verify_page.dart';
import 'components/loading_page.dart';
import 'components/update_dialog.dart';
import 'home/home_page.dart';
import 'onboarding/cache_provider.dart';
import 'onboarding/onboarding_page.dart';
import 'profile/providers/profile_provider.dart';
import 'profile/write_profile_page.dart';

// intial auth and version check widget
class Root extends ConsumerWidget {
  const Root({Key? key}) : super(key: key);

  static const String route = "/root";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // auth check
    final user = ref.watch(userProvider).value;
    // onborading seen check
    final seen =
        ref.read(cacheProvider).value!.getBool(Constants.seen) ?? false;
    // otp verification check
    final bool forVerfiy =
        ref.watch(authProvider.select((value) => value.verificationId != null));
    // app version check
    ref.watch(getAppVersionFutureProvider).when(
        data: (data) async {
          // app version check from appverioncode class and db
          if (data.versionNumber > AppVersionCode.versionCode) {
            await Future.delayed(const Duration(seconds: 2));
            //navigate to update for force update
            // Navigator.pushReplacementNamed(context, UpdatePage.route);
          }
        },
        error: (e, s) {
          print(e); },
        loading: () => Loading());
    // onborading seen check condition
    return !seen
        ? OnboardingPage()
        // auth check condition
        : user == null
            ? Navigator(
                pages: [
                  MaterialPage(child: LoginPage(signUp: user != null)),
                  if (forVerfiy) const MaterialPage(child: VerifyPage())
                ],
                onPopPage: (route, result) => route.didPop(result),
              )
            // get profile data
            : ref.watch(profileProvider).when(
                  data: (profile) {
                    // admin profile check condition
                    return profile.role == Role.user
                        ? ref.watch(marriageProfileProvider).when(
                              // profile status check
                              data: (mProfile) => mProfile.status ==
                                      Status.draft
                                  //profile status check for incomplete profile
                                  ? DetailsPage(mProfile: mProfile)
                                  //profile status check for pending profile and date check for 1 oct
                                  : mProfile.status == Status.pending ||
                                          !DateTime.now()
                                              .isAfter(DateTime(2022, 10, 1))
                                      ? PendingScreen(
                                          mProfile: mProfile,
                                          profile: profile,
                                        )
                                      //profile status check for approved
                                      : mProfile.status == Status.approved
                                          ? const HomePage()
                                          : RejectedScreen(
                                              mProfile: mProfile,
                                              profile: profile,
                                            ),
                              error: (e, s) => e == "data-not-exists"
                                  ? const EmptyPage()
                                  : Scaffold(
                                      body: Center(
                                        child: Text("$e"),
                                      ),
                                    ),
                              loading: () => const LoadingPage(),
                            )
                        : const HomePage();
                  },
                  //if profile not exists navigate to create profile page
                  error: (e, s) => WriteProfilePage(),
                  loading: () => const LoadingPage(),
                );
  }
}
