import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:lev_matrimonial/firebase_options_prod.dart';
import 'package:leva_matrimonial/ui/router.dart';
import 'package:leva_matrimonial/ui/splash/splash_page.dart';
import 'package:leva_matrimonial/utils/labels.dart';

import 'firebase_options.dart';

// flutter build apk --split-per-abi --flavor dev -t lib/dev.dart
// flutter run --flavor dev -t lib/dev.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'leva-matrimonial-test',
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Labels.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardTheme: const CardTheme(clipBehavior: Clip.antiAlias),
        primarySwatch: Colors.orange,

        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      initialRoute: SplashPage.route,
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
