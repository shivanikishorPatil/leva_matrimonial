import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/repositories/profile_repository_provider.dart';

final getAdminListFutureProvider =
    StreamProvider((ref) => ref.watch(profileRepositoryProvider).getAdmins());

class AdminList extends ConsumerWidget {
  const AdminList({Key? key}) : super(key: key);
static const route = "/adminList";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admins = ref.watch(getAdminListFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin List'),
      ),
        body: admins.when(
      data: (data) => data.isEmpty
          ? const Center(
              child: Text('No Admin Profiles'),
            )
          : SingleChildScrollView(
              child: Column(
                  children: data
                      .map((e) => ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(e.email),
                            subtitle: Text('${e.phone} \n ${e.createdAt.year}-${e.createdAt.month}-${e.createdAt.day} ${e.createdAt.hour}:${e.createdAt.minute}'),
                          ))
                      .toList()),
            ),
      error: (e, s) {
        print('getAdmins $e');
        return Center(child: Text(e.toString()));
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
