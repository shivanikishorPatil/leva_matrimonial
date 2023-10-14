import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'pick_image_label.dart';



class ImagePickerView extends StatelessWidget {
  const ImagePickerView({Key? key, this.file, this.image, required this.onPick})
      : super(key: key);

  final ValueChanged<File> onPick;
  final String? image;
  final File? file;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () async {
          final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            onPick(File(pickedFile.path));
          }
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: scheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(12),
            image: file != null
                ? DecorationImage(
                    image: FileImage(file!),
                    fit: BoxFit.cover,
                  )
                : image != null
                    ? DecorationImage(
                        image: NetworkImage(image!),
                        fit: BoxFit.cover,
                      )
                    : null,
          ),
          child: const PickImageLabel(),
        ),
      ),
    );
  }
}
