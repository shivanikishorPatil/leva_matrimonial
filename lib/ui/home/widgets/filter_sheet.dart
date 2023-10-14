import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/ui/components/big_button.dart';
import 'package:leva_matrimonial/ui/home/providers/profiles_view_model_provider.dart';

import '../../../utils/data.dart';

class FilterSheet extends HookConsumerWidget {
  const FilterSheet({Key? key, required this.model}) : super(key: key);
  final ItemsViewModel model;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final ageRange = useState<RangeValues?>(model.ageRange);
    final salaryRange = useState<RangeValues?>(model.salaryRange);
    final eduCategory = useState<String?>(model.eduCategory);
    final height = useState<int?>(model.heightRange);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Filters",
              style: style.headlineSmall,
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: ageRange.value != null,
                  onChanged: (v) {
                    ageRange.value = v! ? const RangeValues(18, 40) : null;
                  }),
              const Text("Age: "),
              if (ageRange.value != null)
                Text(
                  "${ageRange.value!.start.toInt()} to ${ageRange.value!.end.toInt()}",
                  style: style.titleMedium,
                )
            ],
          ),
          if (ageRange.value != null)
            RangeSlider(
              values: ageRange.value!,
              onChanged: (v) => v.start != v.end
                  ? ageRange.value = RangeValues(
                      v.start.toInt().toDouble(), v.end.toInt().toDouble())
                  : null,
              min: 18,
              divisions: 40 - 18,
              max: 40,
              labels: RangeLabels("${ageRange.value!.start.toInt()}",
                  "${ageRange.value!.end.toInt()}"),
            ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              value: Data.eduCategories.contains(eduCategory.value)
                  ? eduCategory.value
                  : null,
              items: Data.eduCategories
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: "Education Category",
                suffixIcon: eduCategory.value != null
                    ? IconButton(
                        onPressed: () {
                          eduCategory.value = null;
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              onChanged: (v) => eduCategory.value = v!,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              value: height.value != null
                  ? Data.heightLabels[height.value!]
                  : null,
              items: Data.heightLabels
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              decoration: InputDecoration(
                labelText: "Height",
                suffixIcon: height.value != null
                    ? IconButton(
                        onPressed: () {
                          height.value = null;
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
              onChanged: (v) => height.value = Data.heightLabels.indexOf(v!),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Checkbox(
                  value: salaryRange.value != null,
                  onChanged: (v) {
                    salaryRange.value =
                        v! ? const RangeValues(5000, 200000) : null;
                  }),
              const Text("Salary: "),
              if (salaryRange.value != null)
                Text(
                  "${salaryRange.value!.start.toInt()} to ${salaryRange.value!.end.toInt()}",
                  style: style.titleMedium,
                )
            ],
          ),
          if (salaryRange.value != null)
            RangeSlider(
              values: salaryRange.value!,
              onChanged: (v) => v.start != v.end
                  ? salaryRange.value = RangeValues(
                      v.start.toInt().toDouble(), v.end.toInt().toDouble())
                  : null,
              min: 5000,
              divisions: 20000 - 500,
              max: 200000,
              labels: RangeLabels("${salaryRange.value!.start.toInt()}",
                  "${salaryRange.value!.end.toInt()}"),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
                onPressed: () {
                  model.ageRange = null;
                  model.salaryRange = null;
                  model.eduCategory = null;
                  model.heightRange = null;
                  model.init();

                  Navigator.pop(context);
                },
                child: Text("CREAR FILTERS")),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BigButton(
              label: "APPLY",
              onPressed: () {
                model.ageRange = ageRange.value;
                model.salaryRange = salaryRange.value;
                model.eduCategory = eduCategory.value;
                model.heightRange = height.value;
                model.init();
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
