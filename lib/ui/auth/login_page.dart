import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/utils/assets.dart';

import '../../utils/data.dart';
import '../../utils/labels.dart';
import '../components/big_button.dart';
import '../components/snackbar.dart';
import 'providers/auth_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key, this.signUp = false}) : super(key: key);
  static const route = "/login";
  final bool signUp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final provider = authProvider;
    final model = ref.read(provider);
    final snackbar = AppSnackbar(context);

    return LoadingLayer(
      child: Scaffold(
        bottomSheet: Consumer(
          builder: (context, ref, child) {
            ref.watch(provider.select((value) => value.phone));

            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BigButton(
                    label: Labels.continue_.toUpperCase(),
                    onPressed: model.phone.length == 10
                        ? () {
                      model.sendOTP(
                        onError: (v) => snackbar.error(v),
                        onMessage: (v) => snackbar.message(v),
                      );
                    }
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '© 2022 Leva Navyuvak Sangh. All Rights Reserved.',
                    style: style.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Center(
                  child: SizedBox(
                    height: 56 * 2,
                    child: Image.asset(Assets.logo),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Labels.appName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: style.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Continue with Mobile Number',
                  style: style.titleLarge,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: model.countryCode,
                            items: Data.countryCodeList.map(
                                  (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ),
                            ).toList(),
                            onChanged: (v) => model.countryCode = v!,
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: model.phone,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: Labels.mobileNumber,
                          prefixIcon: Icon(Icons.call_outlined),
                          // prefixText: "+91 ",
                        ),
                        inputFormatters: [model.formater],
                        onChanged: (v) => model.phone = v,
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
