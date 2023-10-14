import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/ad.dart';
import 'package:leva_matrimonial/repositories/ad_repository_provider.dart';
import 'package:leva_matrimonial/ui/ads/write_ad_page.dart';

import '../providers/write_ad_view_model_provider.dart';

class AdCard extends ConsumerWidget {
  const AdCard({Key? key, required this.e, required this.editable})
      : super(key: key);
  final Ad e;
  final bool editable;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      e.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${e.title}",
                    style: style.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${e.description}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (editable)
              Positioned(
                right: 0,
                child: MaterialButton(
                  color: scheme.secondaryContainer,
                  shape: CircleBorder(),
                  onPressed: () async {
                    final writer = ref.read(writeAdViewModelProvider);
                    writer.initial = e;
                    await Navigator.pushNamed(context, WriteAdPage.route);
                    writer.clear();
                  },
                  child: Icon(Icons.edit),
                ),
              ),
            if (editable)
              Positioned(
                right: 56,
                child: MaterialButton(
                  color: scheme.errorContainer,
                  onPressed: () async {
                    final v = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Are you sure you want to delete this ad?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("NO"),
                          ),
                          MaterialButton(
                            color: theme.errorColor,
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text("YES"),
                          ),
                        ],
                      ),
                    );
                    if (v ?? false) {
                      ref.read(adsRepositoryProvider).delete(e.id);
                    }
                  },
                  shape: CircleBorder(),
                  child: Icon(Icons.delete),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
