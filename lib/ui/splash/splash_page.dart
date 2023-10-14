import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/assets.dart';
import '../../utils/labels.dart';
import '../onboarding/cache_provider.dart';
import '../root.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const String route = "/";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await ref.read(cacheProvider.future);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    // page navigation after splash screen to root 
    Navigator.pushNamedAndRemoveUntil(
      context,
      Root.route,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styles = theme.textTheme;
    return Scaffold(
      backgroundColor: scheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 56 * 2,
              child: Image.asset(Assets.logo),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              Labels.appName.toUpperCase(),
              style: styles.titleLarge!.copyWith(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
