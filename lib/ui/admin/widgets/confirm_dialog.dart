import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final VoidCallback yes;
  final VoidCallback no;
  final Color yesColor;
  const ConfirmDialog(
      {Key? key,
      required this.title,
      required this.yes,
      required this.no,
      this.yesColor = Colors.red})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: no,
          child: const Text("NO"),
        ),
        MaterialButton(
          onPressed: yes,
          color: yesColor,
          child: const Text("YES"),
        )
      ],
    );
  }
}
