import 'package:flutter/material.dart';
import 'package:leva_matrimonial/utils/labels.dart';

class JalgavPage extends StatelessWidget {
  const JalgavPage({Key? key}) : super(key: key);

  static const route = "/jalgav";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Labels.jalgav),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "जळगाव वधु-वर महामेळावा 2022",
              textAlign: TextAlign.center,
              style: style.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "ठिकाण: एकलव्य क्रिडा संकुल",
              textAlign: TextAlign.center,
              style: style.titleLarge,
            ),
            Text(
              "एम. जे. कॉलेज मागे, आय.टी.आय. समोर, जळगाव",
              textAlign: TextAlign.center,
              style: style.titleLarge,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "रविवार, 4 डिसेंबर 2022",
              textAlign: TextAlign.center,
              style: style.titleLarge!.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "सकाळी १० वाजता",
              textAlign: TextAlign.center,
               style: style.titleLarge!.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
