import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/big_button.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/ui/components/snackbar.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_professional_details_page.dart';
import 'package:leva_matrimonial/utils/utils.dart';

import '../../enums/gender.dart';
import '../../enums/marital_status.dart';
import '../../utils/data.dart';
import '../../utils/dates.dart';
import '../../utils/formats.dart';
import 'providers/write_marriage_profile_provider.dart';
import 'widgets/image_picker_view.dart';

class WritePersonalDetailsPage extends HookConsumerWidget {
  WritePersonalDetailsPage({Key? key}) : super(key: key);
  static const route = "/personalDetails";

  final _formKey = GlobalKey<FormState>();

  final provider = writeMarriageProfileProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;

    final model = ref.read(provider);

    final dateController = useTextEditingController(
        text: model.birth != null ? Formats.date(model.birth!) : null);
    final timeController = useTextEditingController(
        text: model.birth != null ? Formats.time(model.birth!) : null);
    ref.watch(provider.select((value) => value.enabled1));

    final next = model.education.isEmpty;
    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Enter Personal Details"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: BigButton(
            label: "SAVE${next ? " & NEXT" : ""}",
            onPressed: () async {
              if (model.gender == null) {
                AppSnackbar(context).error("Select वर/वधू !");
                return;
              } else if (model.maritalStatus == null) {
                AppSnackbar(context).error("Select marital status!");
                return;
              }

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  await model.writeProfile();
                  if (next) {
                    Navigator.pushReplacementNamed(
                        context, WriteProfessionalDetailsPage.route);
                  } else {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e);
                }
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider.select((value) => value.file));
                    return ImagePickerView(
                      onPick: (v) => model.file = v,
                      file: model.file,
                      image: model.image,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.gender));
                  return Row(
                    children: [
                      Radio<Gender>(
                        value: Gender.male,
                        groupValue: model.gender,
                        onChanged: (v) => model.gender = v!,
                      ),
                      const Text("वर"),
                      const SizedBox(width: 16),
                      Radio<Gender>(
                        value: Gender.female,
                        groupValue: model.gender,
                        onChanged: (v) {
                          model.gender = v!;
                        },
                      ),
                      const Text("वधू"),
                    ],
                  );
                }),
                Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.maritalStatus));
                  return Row(
                    children: [
                      Radio<MaritalStatus>(
                        value: MaritalStatus.notmarried,
                        groupValue: model.maritalStatus,
                        onChanged: (v) => model.maritalStatus = v!,
                      ),
                      Text(Data.maritalStatusLabels[MaritalStatus.notmarried] ??
                          ''),
                      const Spacer(),
                      Radio<MaritalStatus>(
                        value: MaritalStatus.divorced,
                        groupValue: model.maritalStatus,
                        onChanged: (v) => model.maritalStatus = v!,
                      ),
                      Text(Data.maritalStatusLabels[MaritalStatus.divorced] ??
                          ''),
                      const Spacer(),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.fname,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "First name",
                  ),
                  onChanged: (v) => model.fname = v.trim(),
                  inputFormatters: [Utils.format, Utils.space],
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.mname,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "Middle name",
                  ),
                  onChanged: (v) => model.mname = v.trim(),
                  inputFormatters: [Utils.format, Utils.space],
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.lname,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "Last name",
                  ),
                  onChanged: (v) => model.lname = v.trim(),
                  inputFormatters: [Utils.format, Utils.space],
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.fnameM,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "पहिले नाव",
                  ),
                  onChanged: (v) => model.fnameM = v.trim(),
                  inputFormatters: [Utils.formatM, Utils.space],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.mnameM,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "वडिलांचे नाव",
                  ),
                  onChanged: (v) => model.mnameM = v.trim(),
                  inputFormatters: [Utils.formatM, Utils.space],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.lnameM,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "आडनाव",
                  ),
                  onChanged: (v) => model.lnameM = v.trim(),
                  inputFormatters: [Utils.formatM, Utils.space],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.originalFrom,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "मुळगाव",
                  ),
                  onChanged: (v) => model.originalFrom = v.trim(),
                  inputFormatters: [Utils.formatM],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,

                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.taluka,
                  textCapitalization: TextCapitalization.words,
                  //TODO: marathi
                  decoration: const InputDecoration(
                    labelText: "तालुका",
                  ),
                  onChanged: (v) => model.taluka = v.trim(),
                  inputFormatters: [Utils.formatM],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.district,
                  textCapitalization: TextCapitalization.words,
                  //TODO: marathi
                  decoration: const InputDecoration(
                    labelText: "जिल्हा",
                  ),
                  onChanged: (v) => model.district = v.trim(),
                  inputFormatters: [Utils.formatM],
                  validator: Utils.validateMarathiField,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.birthName,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "जन्म नाव",
                  ),
                  validator: Utils.validateMarathiField,
                  onChanged: (v) => model.birthName = v.trim(),
                  inputFormatters: [Utils.formatM],
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider.select((value) => value.gender));
                    if (model.gender == Gender.male &&
                        model.birth != null &&
                        (Dates.today.difference(model.birth!).inDays ~/ 365) <
                            21) {
                      model.birth = null;
                      dateController.clear();
                      timeController.clear();
                    }
                    return TextFormField(
                      controller: dateController,
                      validator: Utils.validate,
                      readOnly: true,
                      onTap: () async {
                        final initial =
                            model.gender == Gender.male ? Dates.y21 : Dates.y18;
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: model.birth ?? initial,
                          firstDate: DateTime(1960),
                          lastDate: initial,
                        );
                        if (picked != null) {
                          if (model.birth != null) {
                            model.birth = DateTime(
                              picked.year,
                              picked.month,
                              picked.day,
                              model.birth!.hour,
                              model.birth!.minute,
                            );
                          } else {
                            model.birth = picked;
                          }
                          dateController.text = Formats.date(model.birth!);
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "Birth Date (जन्म तारीख)",
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, child) {
                    ref.watch(provider.select((value) => value.birth));
                    ref.watch(provider.select((value) => value.gender));
                    return TextFormField(
                      validator: Utils.validate,
                      enabled: model.birth != null,
                      readOnly: true,
                      controller: timeController,
                      decoration: const InputDecoration(
                        labelText: "Birth Time (जन्म वेळ)",
                      ),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          model.birth = DateTime(
                            model.birth!.year,
                            model.birth!.month,
                            model.birth!.day,
                            picked.hour,
                            picked.minute,
                          );
                          timeController.text = Formats.time(model.birth!);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.birthPlace,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "जन्म स्थळ",
                  ),
                  validator: Utils.validateMarathiField,
                  inputFormatters: [
                    Utils.formatM,
                  ],
                  onChanged: (v) => model.birthPlace = v.trim(),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  validator: Utils.validate,
                  value:
                      Data.heights.contains(model.height) ? model.height : null,
                  items: Data.heights
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                      labelText: "उंची", suffixText: "foot/inch"),
                  onChanged: (v) => model.height = v!,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  validator: Utils.validate,
                  value: Data.gotras.contains(model.gotr) ? model.gotr : null,
                  items: Data.gotras
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: "गोत्र",
                  ),
                  onChanged: (v) => model.gotr = v!,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  validator: Utils.validate,
                  value: Data.varns.contains(model.varn) ? model.varn : null,
                  items: Data.varns
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: "वर्ण",
                  ),
                  onChanged: (v) => model.varn = v!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
