import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options_prod.dart';
import 'package:leva_matrimonial/ui/router.dart';
import 'package:leva_matrimonial/ui/splash/splash_page.dart';
import 'package:leva_matrimonial/utils/labels.dart';



// before building for prod please change urls for excel downloads in drawer.dart,excel_repo.dart and pdf in deatils_page.dart
// prod flavor 
// flutter build apk --split-per-abi --flavor prod -t lib/main.dart
// flutter run --flavor prod -t lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptionsProd.currentPlatform);
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
      // splash screen route
      initialRoute: SplashPage.route,
      // all routes
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
