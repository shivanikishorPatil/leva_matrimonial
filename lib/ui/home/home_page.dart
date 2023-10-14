import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// ignore: depend_on_referenced_packages
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/ui/admin/admin_page.dart';
import 'package:leva_matrimonial/ui/home/widgets/drawer.dart';
import 'package:leva_matrimonial/ui/marriage_profile/details_root.dart';
import 'package:leva_matrimonial/ui/profile/providers/profile_provider.dart';
import 'package:leva_matrimonial/utils/labels.dart';

import '../../models/params.dart';
import '../auth/providers/auth_provider.dart';
import '../components/pagination_view.dart';
import '../components/search_bar.dart';
import 'providers/profiles_view_model_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controller = useTabController(initialLength: 2);
    final auth = ref.watch(authProvider);
    final profile = ref.read(profileProvider).value!;
    return Scaffold(
      drawer: AppDrawer(profile: profile,),
      appBar: AppBar(
        title: const Text(Labels.appName),
        actions: [
          profile.role == Role.user
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, DetailsRoot.route);
                  },
                  icon: Icon(Icons.person_outline_rounded),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AdminPage.route);
                  },
                  icon: Icon(Icons.manage_accounts),
                ),
          IconButton(
            onPressed: () {
              auth.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
        bottom: TabBar(
          controller: controller,
          tabs: const [
            Tab(
              text: "वर",
            ),
            Tab(
              text: "वधू",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: Gender.values.map((e) {
          final provider = itemsViewModelProvider(
            Params(gender: e, status: Status.approved),
          );
          final model = ref.watch(provider);
          return Column(
            children: [
              // SearchBar(model: model),
              PaginationView(
                busy: model.busy,
                items: model.items,
                onLoadMore: () => model.loadMore(),
                onRefresh: () => model.init(),
                loading: model.loading,
                scroll: model.scroll,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
