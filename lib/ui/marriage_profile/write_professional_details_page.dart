import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/ui/marriage_profile/write_family_details_page.dart';

import '../../utils/data.dart';
import '../../utils/labels.dart';
import '../../utils/utils.dart';
import '../components/big_button.dart';
import 'providers/write_marriage_profile_provider.dart';

class WriteProfessionalDetailsPage extends ConsumerWidget {
  WriteProfessionalDetailsPage({Key? key}) : super(key: key);
  static const route = "/professionalDetails";

  final _formKey = GlobalKey<FormState>();
  final provider = writeMarriageProfileProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(provider);
    ref.watch(provider.select((value) => value.needJobDetails));
    final next = model.ffatherNameM.isEmpty;

    final extraLabel = model.needJobDetails ? "" : " ${Labels.optional}";
    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Enter Professional Details"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: BigButton(
            label: "SAVE${next ? " & NEXT" : ""}",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                try {
                  await model.writeProfile();
                  if (next) {
                    Navigator.pushReplacementNamed(
                        context, WriteFamilyDetailsPage.route);
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
                const SizedBox(height: 8),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.education,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: "Education (शिक्षण)",
                  ),
                  onChanged: (v) => model.education = v.trim(),
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: Data.eduCategories.contains(model.eduCategory)
                      ? model.eduCategory
                      : null,
                  items: Data.eduCategories
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: "Education Category (शैक्षणिक वर्गीकरण)",
                  ),
                  onChanged: (v) => model.eduCategory = v!,
                  validator: Utils.validate,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.job,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "नोकरी पद/हुद्दा (Job Designation) $extraLabel",
                  ),
                  // inputFormatters: [
                  //   Utils.formatM,
                  // ],
                  validator:
                      model.needJobDetails ? Utils.validate : (v) => null,
                  onChanged: (v) => model.job = v.crim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.company,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "नोकरी कंपनी$extraLabel",
                  ),
                  // inputFormatters: [
                  //   Utils.formatM,
                  // ],
                  validator:
                      model.needJobDetails ? Utils.validate : (v) => null,
                  onChanged: (v) => model.company = v.crim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.jobPlace,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "नोकरी स्थळ $extraLabel",
                  ),
                  inputFormatters: [
                    Utils.formatAddressM,
                  ],
                  validator: model.needJobDetails
                      ? Utils.validateMarathiField
                      : (v) => null,
                  onChanged: (v) => model.jobPlace = v.crim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.salary?.toString(),
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: "${Labels.rupee} ",
                    suffixText: "per month",
                    labelText: "Monthly Salary $extraLabel",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (v) => model.salary = int.tryParse(v),
                  validator: (v) => model.needJobDetails
                      ? int.tryParse(v!) == null
                          ? "Enter valid salary"
                          : int.parse(v) == 0
                              ? "Salary should be greater than 0"
                              : null
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: model.expectation,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: "अपेक्षा",
                  ),
                  // inputFormatters: [
                  //   Utils.formatM,
                  // ],
                  validator: Utils.validate,
                  onChanged: (v) => model.expectation = v.trim(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
