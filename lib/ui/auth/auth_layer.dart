
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:leva_matrimonial/ui/home_page.dart';

// import '../../utils/labels.dart';
// import '../profile/write_profile_page.dart';
// import 'login_page.dart';
// import 'providers/auth_provider.dart';
// import 'providers/user_provider.dart';
// import 'verify_page.dart';

// class AuthLayer extends ConsumerWidget {
//   const AuthLayer({Key? key, this.child}) : super(key: key);
//   final Widget? child;
//   static const route = "/auth";
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

        
//         // ref.watch(profileProvider).when(
//         //       data: (profile) {
//         //         if (child == null) {
//         //           Future.delayed(Duration(milliseconds: 200)).whenComplete(() {
//         //             Navigator.pop(context);
//         //           });
//         //           return LoadingPage();
//         //         }
//         //         return child!;
//         //       },
//         //       error: (e, s) => WriteProfilePage(),
//         //       loading: () => LoadingPage(),
//         //     );
//   }
// }
