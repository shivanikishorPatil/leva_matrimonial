import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/utils/utils.dart';
import '../../utils/labels.dart';
import '../components/big_button.dart';
import 'providers/write_marriage_profile_provider.dart';

class WriteFamilyDetailsPage extends ConsumerWidget {
  WriteFamilyDetailsPage({Key? key}) : super(key: key);
  static const route = "/familyDetails";

  final _formKey = GlobalKey<FormState>();

  final provider = writeMarriageProfileProvider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final model = ref.read(writeMarriageProfileProvider);
    String? validatePhone(String? v) {
      return v!.isEmpty
          ? "Required"
          : v.length != 10
              ? "Enter valid number"
              : null;
    }

    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Enter Family Details"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: BigButton(
            label: "SAVE",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await model.writeProfile();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "अविवाहित बहिण",
                  style: style.titleMedium,
                ),
                Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.unmarriedSisters));
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (model.unmarriedSisters > 0) {
                            model.unmarriedSisters--;
                          }
                        },
                      ),
                      Text(model.unmarriedSisters.toString()),
                      IconButton(
                          onPressed: () {
                            if (model.unmarriedSisters < 6) {
                              model.unmarriedSisters++;
                            }
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Text(
                  "विवाहित बहिण",
                  style: style.titleMedium,
                ),
                Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.marriedSisters));
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (model.marriedSisters > 0) {
                            model.marriedSisters--;
                          }
                        },
                      ),
                      Text(model.marriedSisters.toString()),
                      IconButton(
                          onPressed: () {
                            if (model.marriedSisters < 6) {
                              model.marriedSisters++;
                            }
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Text(
                  "अविवाहित भाऊ",
                  style: style.titleMedium,
                ),
                Consumer(builder: (context, ref, child) {
                  ref.watch(
                      provider.select((value) => value.unmarriedBrothers));
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (model.unmarriedBrothers > 0) {
                            model.unmarriedBrothers--;
                          }
                        },
                      ),
                      Text(model.unmarriedBrothers.toString()),
                      IconButton(
                          onPressed: () {
                            if (model.unmarriedBrothers < 6) {
                              model.unmarriedBrothers++;
                            }
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                Text(
                  "विवाहित भाऊ",
                  style: style.titleMedium,
                ),
                Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.marriedBrothers));
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (model.marriedBrothers > 0) {
                            model.marriedBrothers--;
                          }
                        },
                      ),
                      Text(model.marriedBrothers.toString()),
                      IconButton(
                        onPressed: () {
                          if (model.marriedBrothers < 6) {
                            model.marriedBrothers++;
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.ffatherNameM,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "वडिलांचे पहिले नाव",
                  ),
                  onChanged: (v) => model.ffatherNameM = v.trim(),
                  inputFormatters: [Utils.formatM, Utils.space],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.mfatherNameM,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "वडिलांचे मधले नाव",
                  ),
                  onChanged: (v) => model.mfatherNameM = v.trim(),
                  inputFormatters: [Utils.formatM, Utils.space],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.lfatherNameM,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "वडिलांचे आडनाव",
                  ),
                  onChanged: (v) => model.lfatherNameM = v.trim(),
                  inputFormatters: [Utils.formatM, Utils.space],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.fatherAddress,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "वडिलांचा पत्ता",
                  ),
                  onChanged: (v) => model.fatherAddress = v.trim(),
                  inputFormatters: [Utils.formatAddressM],
                  validator: (v) => Utils.validateMarathiField(v, number: true),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.fatherDesignation,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "वडिलांची नोकरी",
                  ),
                  onChanged: (v) => model.fatherDesignation = v.trim(),
                  // inputFormatters: [Utils.formatM],
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  initialValue: model.fatherMobile1,
                  decoration: const InputDecoration(
                    labelText: "Father(वडिलांचा) mobile no. 1",
                    prefixText: "+91 ",
                  ),
                  validator: validatePhone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (v) => model.fatherMobile1 = v.trim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  initialValue: model.fatherMobile2,
                  decoration: const InputDecoration(
                      labelText: "Father(वडिलांचा) mobile no. 2 (optional)",
                      prefixText: "+91 "),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) =>
                      value!.isNotEmpty ? validatePhone(value) : null,
                  onChanged: (v) => model.fatherMobile2 = v.trim(),
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider.select((value) => value.needContact1));
                    final extraLabel =
                        model.needContact1 ? "" : " ${Labels.optional}";
                    return Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.fcontactName1,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्काचे पहिले नाव-1 $extraLabel",
                          ),
                          onChanged: (v) => model.fcontactName1 = v.crim(),
                          inputFormatters: [Utils.formatM, Utils.space],
                          validator: model.needContact1
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.mcontactName1,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्काचे मधले नाव-1 $extraLabel",
                          ),
                          onChanged: (v) => model.mcontactName1 = v.crim(),
                          inputFormatters: [Utils.formatM, Utils.space],
                          validator: model.needContact1
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.lcontactName1,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्काचे शेवटचे नाव-1 $extraLabel",
                          ),
                          onChanged: (v) => model.lcontactName1 = v.crim(),
                          inputFormatters: [Utils.formatM, Utils.space],
                          validator: model.needContact1
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.contact1city,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्क १ व्यक्तीचे गाव $extraLabel",
                          ),
                          onChanged: (v) => model.contact1city = v.crim(),
                          inputFormatters: [Utils.formatM, Utils.space],
                          validator: model.needContact1
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          initialValue: model.contact1,
                          decoration: InputDecoration(
                            labelText: "Contact(संपर्क) no. 1$extraLabel",
                            prefixText: "+91 ",
                          ),
                          validator:
                              model.needContact1 ? validatePhone : (v) => null,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (v) => model.contact1 = v.crim(),
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider.select((value) => value.needContact2));
                    final extraLabel =
                        model.needContact2 ? "" : " ${Labels.optional}";
                    return Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.fcontactName2,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्काचे पहिले नाव-2 $extraLabel",
                          ),
                          onChanged: (v) => model.fcontactName2 = v.crim(),
                          inputFormatters: [Utils.formatM],
                          validator: model.needContact2
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.mcontactName2,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्काचे मधले नाव-2 $extraLabel",
                          ),
                          onChanged: (v) => model.mcontactName2 = v.crim(),
                          inputFormatters: [Utils.formatM],
                          validator: model.needContact2
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: model.lcontactName2,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: "संपर्काचे शेवटचे नाव-2 $extraLabel",
                          ),
                          onChanged: (v) => model.lcontactName2 = v.crim(),
                          inputFormatters: [Utils.formatM],
                          validator: model.needContact2
                              ? Utils.validateMarathiField
                              : (v) => null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                            textInputAction: TextInputAction.done,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: model.contact2city,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: "संपर्क २ व्यक्तीचे गाव $extraLabel",
                            ),
                            onChanged: (v) => model.contact2city = v.crim(),
                            inputFormatters: [Utils.formatM, Utils.space],
                            validator: model.needContact2
                                ? Utils.validateMarathiField
                                : (v) => null),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          initialValue: model.contact2,
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: "Contact(संपर्क) no. 2$extraLabel",
                            prefixText: "+91 ",
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator:
                              model.needContact2 ? validatePhone : (v) => null,
                          onChanged: (v) => model.contact2 = v.crim(),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
