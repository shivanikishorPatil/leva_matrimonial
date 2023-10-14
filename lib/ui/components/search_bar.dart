import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../home/providers/profiles_view_model_provider.dart';
import '../home/widgets/filter_sheet.dart';

class SearchBar extends HookWidget {
  const SearchBar({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ItemsViewModel model;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final searchController = useTextEditingController();
    final value = useRef('');

    if (model.debouncer.value.isEmpty) {
      print("SSS");
      searchController.clear();
      value.value = '';
    }
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();
                    value.value = '';
                    model.debouncer.value = '';
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (v) {
                if (v != value.value) {
                  model.debouncer.value = v;
                  value.value = v;
                }
              },
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor,
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => FilterSheet(model: model),
                  );
                },
                icon: Stack(
                  children: [
                    const Icon(Icons.filter_alt),
                  ],
                ),
              ),
             if(model.filterCount!=0) Positioned(
              right: 0,
               child: Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: Text(
                    "${model.filterCount}",
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.primary
                    ),
                  ),
               ),
             ),
            ],
          ),
        ],
      ),
    );
  }
}
