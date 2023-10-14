import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/ui/marriage_profile/providers/marriage_profile_provider.dart';
import 'package:leva_matrimonial/ui/profile/providers/profile_provider.dart';

import '../../utils/labels.dart';
import '../components/snackbar.dart';
import 'providers/auth_provider.dart';

class VerifyPage extends HookConsumerWidget {
  const VerifyPage({Key? key}) : super(key: key);
  static const route = "/verify";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = authProvider;
    final model = ref.read(provider);
    final controller = useTextEditingController();
    final snackbar = AppSnackbar(context);
    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => model.verificationId = null,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "A verification code has been sent to ${model.countryCode}${model.phone}, please enter it here to verify.",
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: Labels.code,
                  ),
                  inputFormatters: [model.codeformater],
                  onChanged: (v) async {
                    model.code = model.codeformater.getUnmaskedText();
                    if (model.code.length == 6) {
                      try {
                        await model.verifyOTP(clear: () {
                          controller.clear();
                          model.codeformater.clear();
                          ref.refresh(profileProvider);
                          ref.refresh(marriageProfileProvider);
                        });
                      } catch (e) {
                        snackbar.error(e);
                      }
                    }
                  },
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                StreamBuilder<int>(
                    initialData: 30,
                    stream: model.stream,
                    builder: (context, snapshot) {
                      final enable = (snapshot.data ?? 0) <= 0;
                      return TextButton.icon(
                        onPressed: enable
                            ? () {
                                model.sendOTP(
                                  onError: (v) => snackbar.error(v),
                                  onMessage: (v) => snackbar.message(v),
                                );
                              }
                            : null,
                        icon: const Icon(Icons.refresh),
                        label: Text(
                            "Resend OTP${enable ? "" : " in ${snapshot.data}s"}"),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
