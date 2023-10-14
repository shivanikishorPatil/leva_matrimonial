import 'package:flutter/material.dart';

import 'confirm_dialog.dart';

class ApporvalButtons extends StatelessWidget {
  const ApporvalButtons(
      {Key? key, required this.onAccepted, required this.onRejected})
      : super(key: key);

  final VoidCallback onAccepted;
  final VoidCallback onRejected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: TextButton(
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(Colors.green),
              //   shape: MaterialStateProperty.all(
              //     const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              onPressed: () async {
                final val = await showDialog(
                  context: context,
                  builder: (_) => ConfirmDialog(
                      title: "Are you sure you want to Accept",
                      yesColor: Colors.green,
                      yes: () {
                        Navigator.pop(context, true);
                      },
                      no: () {
                        Navigator.pop(context);
                      }),
                );
                if (val != null) {
                  onAccepted();
                }
              },
              child: Text(
                "Accept",
                style: style.button!.copyWith(color: Colors.green),
              ),
            ),
          ),
          const VerticalDivider(),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: TextButton(
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(Colors.red),
              //   shape: MaterialStateProperty.all(
              //     const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //         bottomRight: Radius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
              onPressed: () async {
                final val = await showDialog(
                  context: context,
                  builder: (_) => ConfirmDialog(
                      title: "Are you sure you want to Reject",
                      yes: () {
                        Navigator.pop(context, true);
                      },
                      no: () {
                        Navigator.pop(context);
                      }),
                );
                if (val != null) {
                  onRejected();
                }
              },
              child: Text(
                "Reject",
                style: style.button!.copyWith(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }
}
