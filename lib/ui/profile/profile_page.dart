
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../../models/profile.dart';
// import '../auth/providers/auth_provider.dart';
// import 'providers/profile_provider.dart';
// import 'write_profile_page.dart';

// class ProfilePage extends ConsumerWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//   static const String route = "/profile";
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = Theme.of(context);
//     final scheme = theme.colorScheme;
//     final style = theme.textTheme;
//     final user = ref.watch(userProvider).value;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Profile"),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(8),
//         children: [
//           const SizedBox(height: 8),
//           Consumer(
//             builder: (context, ref, child) {
//               print(user?.uid);
//               return user == null
//                   ? const ProfileView()
//                   : ref.watch(profileProvider).when(
//                         data: (profile) => ProfileView(
//                           profile: profile,
//                           user: user,
//                         ),
//                         error: (e, s) => ProfileView(user: user),
//                         loading: () => const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//             },
//           ),
//           const SizedBox(height: 8),
//           const Divider(height: 0.5),
//           const MenuTile(
//             label: "Help",
//             route: '',
//           ),
//           const Divider(height: 0.5),
//           const MenuTile(
//             label: "FAQ",
//             route: '',
//           ),
//           const SizedBox(height: 16),
//           if (user != null)
//             Center(
//                 child: OutlinedButton(
//               style: ButtonStyle(
//                   padding:
//                       MaterialStateProperty.all(theme.buttonTheme.padding)),
//               onPressed: () async {
//                 ref.read(authProvider).signOut();
//               },
//               child: const Text("Logout"),
//             )),
//           const SizedBox(height: 16),
//           Text(
//             "Version 1.0",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: style.caption!.color),
//           ),
//           const SizedBox(height: 16),
//           SizedBox(height: 300)
//         ],
//       ),
//     );
//   }
// }

// class MenuTile extends StatelessWidget {
//   const MenuTile({
//     Key? key,
//     required this.route,
//     required this.label,
//   }) : super(key: key);
//   final String label;
//   final String route;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       trailing: Icon(Icons.keyboard_arrow_right_rounded),
//       onTap: () {
//         // Navigator.pushNamed(context, route);
//       },
//       title: Text(label),
//     );
//   }
// }

// class ProfileView extends StatelessWidget {
//   const ProfileView({Key? key, this.user, this.profile}) : super(key: key);
//   final User? user;
//   final Profile? profile;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final scheme = theme.colorScheme;
//     final style = theme.textTheme;
//     print(user?.providerData.map((e) => e.providerId));
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Center(
//             child: CircleAvatar(
//               radius: 56,
//               backgroundImage: profile?.image != null || user?.photoURL != null
//                   ? NetworkImage(profile?.image ?? user!.photoURL!)
//                   : null,
//               child: user?.photoURL == null && profile?.image == null
//                   ? Icon(
//                       user == null
//                           ? Icons.question_mark
//                           : Icons.person_outline_rounded,
//                       color: scheme.onSurfaceVariant,
//                     )
//                   : null,
//             ),
//           ),
//         ),
//         if (profile?.name != null || user?.displayName != null)
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Text(
//               profile?.name ?? user!.displayName!,
//               style: style.titleMedium,
//             ),
//           ),
//         if (profile?.phone != null || (user?.phoneNumber != null&&user!.phoneNumber!.isNotEmpty))
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Text(profile?.phone ?? user!.phoneNumber!),
//           ),
//         if (profile?.email != null || user?.email != null)
//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Text(profile?.email ?? user!.email!),
//           ),
//         if (user != null)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: user!.providerData
//                 .map((e) => e.providerId)
//                 .map((e) =>
//                     <String, Widget>{
//                       Constants.facebookProvider: FacebookProviderIcon(),
//                       Constants.googleProvider: GoogleProviderIcon(),
//                       Constants.phoneProvider: PhoneProviderIcon(),
//                     }[e] ??
//                     SizedBox())
//                 .map(
//                   (e) => Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: e,
//                   ),
//                 )
//                 .toList(),
//           ),
//         const SizedBox(height: 8),
//         if ( profile == null)
//           Padding(
//             padding: const EdgeInsets.all(4),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, AuthLayer.route);
//               },
//               child: Text(user == null
//                   ? Labels.loginSignUp
//                   : !user!.providerData
//                           .map((e) => e.providerId)
//                           .contains(Constants.phoneProvider)
//                       ? "Link mobile number"
//                       : "Create Profile"),
//             ),
//           ),
//         if (profile != null)
//           ListTile(
//             trailing: Icon(Icons.keyboard_arrow_right_rounded),
//             title: Text("Edit profile"),
//             onTap: () async {
//               await Navigator.pushNamed(context, WriteProfilePage.route);
//             },
//           )
//       ],
//     );
//   }
// }
