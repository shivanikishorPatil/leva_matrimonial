import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/onboarding/cache_provider.dart';
import 'package:leva_matrimonial/utils/assets.dart';

import '../../utils/constants.dart';
import '../root.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  const OnboardingItem(
      {required this.image, required this.title, required this.description});
}

class OnboardingPage extends HookConsumerWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final _items = [Assets.logo, Assets.tower, Assets.kantiseth];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final controller = useTabController(initialLength: _items.length);

    final index = useState(0);

    controller.addListener(() {
      if (index.value != controller.index) {
        index.value = controller.index;
      }
    });

    void done() async {
      await ref.read(cacheProvider).value!.setBool(Constants.seen, true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Root.route);
    }

    return Scaffold(
      backgroundColor: theme.cardColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: done,
              child: Text("SKIP"),
            ),
            MaterialButton(
              color: scheme.primary,
              onPressed: () {
                if (controller.index < 1) {
                  index.value += 1;
                  controller.animateTo(controller.index + 1);
                } else {
                  done();
                }
              },
              child: Text(index.value == 1 ? "DONE" : "NEXT"),
            ),
          ],
        ),
      ),
      bottomSheet: Material(
        color: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _items.length,
              (i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: ShapeDecoration(
                    shape: const StadiumBorder(),
                    color: index.value == i
                        ? scheme.tertiary
                        : scheme.tertiaryContainer,
                  ),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    reverseDuration: Duration(milliseconds: 500),
                    child: SizedBox(
                      height: 16,
                      width: index.value == i ? 32 : 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: _items
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 32,
                      child: Image.asset(e),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
