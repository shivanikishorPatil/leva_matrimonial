import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: depend_on_referenced_packages
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/ui/admin/providers/profiles_provider.dart';
import 'package:leva_matrimonial/ui/marriage_profile/details_root.dart';
import 'package:leva_matrimonial/ui/profile/providers/profile_provider.dart';

import '../../models/params.dart';
import '../auth/providers/auth_provider.dart';
import '../components/pagination_view.dart';
import '../components/search_bar.dart';
import '../home/providers/profiles_view_model_provider.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);
  static const route = "/admin";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controller = useTabController(initialLength: 4);
    final controller2 = useTabController(initialLength: 2);
    final auth = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          tabs: const [
            Tab(
              text: "Approved",
            ),
            Tab(
              text: "Pending",
            ),
            Tab(
              text: "Rejected",
            ),
            Tab(
              text: "Married",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Status.approved,
          Status.pending,
          Status.rejected,
          Status.married
        ]
            .map(
              (s) => Column(
                children: [
                  TabBar(
                    controller: controller2,
                    tabs: const [
                      Tab(
                        text: "वर",
                      ),
                      Tab(
                        text: "वधू",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller2,
                      children: Gender.values.map((e) {
                        return Consumer(
                          builder: (context, ref, child) {
                            final param = Params(gender: e, status: s);
                            final provider = itemsViewModelProvider(param);
                            final streamProvider = profilesProvider(e);
                            final model = ref.watch(provider);
                            final snapshots =
                                ref.watch(streamProvider).asData?.value ?? [];
                            final list = (snapshots + model.items)
                                      .toSet()
                                      .toList()
                                      .where((element) => element.status == s)
                                      .where((element) =>
                                          model.debouncer.value.isNotEmpty
                                              ? element.keys.contains(
                                                  model.debouncer.value
                                                      .toLowerCase(),
                                                )
                                              : true)
                                      .where((element) =>
                                          model.heightRange != null
                                              ? model.heightRange == element.hr
                                              : true)
                                      .where((element) =>
                                          model.eduCategory != null
                                              ? model.eduCategory ==
                                                  element.eduCategory
                                              : true)
                                      .where(
                                        (element) => model.salaryRange != null
                                            ? element.salary != null &&
                                                element.salary! >=
                                                    model.salaryRange!.start &&
                                                element.salary! <=
                                                    model.salaryRange!.end
                                            : true,
                                      )
                                      .toList();
                            return Column(
                              children: [
                                // SearchBar(model: model),
                                PaginationView(
                                  busy: model.busy,
                                  items: model.ageRange!=null?model.profiles(list):list,
                                  onLoadMore: model.loadMore,
                                  onRefresh: () {
                                    ref.refresh(provider);
                                  },
                                  loading: model.loading,
                                  scroll: model.scroll,
                                ),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
