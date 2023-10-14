import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({Key? key,required this.label,this.onPressed}) : super(key: key);
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme  = theme.colorScheme;
    return MaterialButton(
      minWidth: double.infinity,
      disabledColor: scheme.surfaceVariant,
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: onPressed,
      color: scheme.primaryContainer,
      child: Text(label),
    );
  }
}
