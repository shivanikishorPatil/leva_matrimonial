import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/big_button.dart';
import '../components/loading_layer.dart';
import 'providers/write_profile_provider.dart';

class WriteProfilePage extends ConsumerWidget {
  WriteProfilePage({Key? key}) : super(key: key);
  static const String route = '/writeProfile';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = writeProfileProvider;
    final model = ref.read(provider);

    final format = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"));
    final space = FilteringTextInputFormatter.deny(RegExp(" "));
    return WillPopScope(
      onWillPop: () async {
        model.clear();
        return true;
      },
      child: LoadingLayer(
        child: Scaffold(
          appBar: AppBar(
            title: Text(model.edit ? "Edit profile" : "Enter Your Email"),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
            child: Consumer(
              builder: (context, ref, child) {
                ref.watch(provider);
                return BigButton(
                  onPressed: model.enabled
                      ? () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              await model.writeProfile();
                              if (model.edit) {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          }
                        }
                      : null,
                  label: model.edit ? "SAVE" : "CONTINUE",
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    TextFormField(
                      initialValue: model.email,
                      onChanged: (v) => model.email = v,
                      validator: (v) => EmailValidator.validate(v!)
                          ? null
                          : "Enter valid email!",
                      decoration: const InputDecoration(
                          labelText: "Email Address (ईमेल)"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
