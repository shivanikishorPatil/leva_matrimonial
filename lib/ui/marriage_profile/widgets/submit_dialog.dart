import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';

import '../../../utils/utils.dart';

class SubmitDialog extends ConsumerWidget {
  SubmitDialog({Key? key, required this.id}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return AlertDialog(
      title: Text(
        "वरील संपूर्ण माहिती सत्य आहे  खोटी किंवा विपर्यास्त आढळल्यास मी जबाबदार राहील.",
        style: style.titleMedium,
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: "This form is filled by",
          ),
          onSaved: (v) {
            try {
              ref.read(marriageProfileRepositoryProvider).submit(id, name: v!);
            } catch (e) {
              print(e);
            }
            Navigator.pop(context);
          },
          inputFormatters: [Utils.denyEmoji,Utils.formatM],
          validator: Utils.validate,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("NO"),
        ),
        MaterialButton(
          color: theme.colorScheme.primary,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            }
          },
          child: Text("YES"),
        ),
      ],
    );
  }
}
