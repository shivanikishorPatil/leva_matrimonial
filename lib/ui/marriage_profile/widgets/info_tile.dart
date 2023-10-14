import 'package:flutter/material.dart';



class InfoTile extends StatelessWidget {
  const InfoTile({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(color: style.bodySmall!.color),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: style.labelLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
