import 'package:flutter/material.dart';
import 'package:leva_matrimonial/utils/labels.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static const route = "/contact";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Labels.contactUs),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Himalay Tractors",
              textAlign: TextAlign.center,
              style: style.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: scheme.primary),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "2, Navi Peth,\nChitra Chowk, Jalgaon",
              textAlign: TextAlign.center,
              style: style.titleMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              children: ["+918055517377", "+918055567377", "+918275709077"]
                  .map(
                    (e) => GestureDetector(
                      child: Text(
                        e,
                        style: style.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.secondary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () async {
                        try {
                          await launchUrlString("tel:$e");
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: {
                "Levasangh.com": "https://levasangh.com",
                "Levasangh Android app": "",
                "Levasangh Apple app store": "",
              }
                  .entries
                  .map(
                    (e) => GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e.key,
                          style: style.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: scheme.primary,
                          ),
                        ),
                      ),
                      onTap: () async {
                        try {
                          await launchUrlString(e.value);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  )
                  .toList(),
            ),

            ///Levasangh.com | Levasangh Android app | Levasangh Apple app store
          ],
        ),
      ),
    );
  }
}
