import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leva_matrimonial/ui/components/big_button.dart';
import 'package:leva_matrimonial/ui/marriage_profile/widgets/image_picker_view.dart';

import '../components/loading_layer.dart';
import '../components/snackbar.dart';
import 'providers/write_ad_view_model_provider.dart';

class WriteAdPage extends ConsumerWidget {
  const WriteAdPage({Key? key}) : super(key: key);
  static const String route = "/writeAd";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    final provider = writeAdViewModelProvider;
    final model = ref.read(writeAdViewModelProvider);
    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${model.edit ? "Edit" : "Add"} Ad"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Consumer(builder: (context, ref, child) {
            ref.watch(provider);
            return BigButton(
             
              onPressed: model.enabled
                  ? () async {
                      try {
                        await model.write();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      } catch (e) {
                        AppSnackbar(context).error(e);
                      }
                    }
                  : null,
              label: "DONE",
            );
          }),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, ref,child) {
                  ref.watch(provider.select((value) => value.file));
                  return ImagePickerView(
                    onPick: (v) => model.file = v,
                    file: model.file,
                    image: model.image,
                  );
                }
              ),
              const SizedBox(height: 24),
              TextFormField(
                initialValue: model.title,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                onChanged: (v) => model.title = v,
              ),
              const SizedBox(height: 24),
              TextFormField(
                maxLines: 10,
                minLines: 5,
                textInputAction: TextInputAction.done,
                initialValue: model.description,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
                onChanged: (v) => model.description = v,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
