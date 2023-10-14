import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/role.dart';
import 'package:leva_matrimonial/repositories/excel_repository_provider.dart';
import 'package:leva_matrimonial/ui/admin/admin_list.dart';
import 'package:leva_matrimonial/ui/ads/ads_page.dart';
import 'package:leva_matrimonial/ui/components/loading_layer.dart';
import 'package:leva_matrimonial/ui/providers/loading_provider.dart';
import 'package:leva_matrimonial/ui/static/about_page.dart';
import 'package:leva_matrimonial/ui/static/board_page.dart';
import 'package:leva_matrimonial/ui/static/contact_page.dart';
import 'package:leva_matrimonial/ui/static/gallary_page.dart';
import 'package:leva_matrimonial/ui/static/jalgav_page.dart';
import 'package:leva_matrimonial/utils/constants.dart';
import 'package:leva_matrimonial/utils/labels.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../../models/profile.dart';
import '../../../utils/app_version.dart';
import '../../components/snackbar.dart';

class AppDrawer extends ConsumerWidget {
  final Profile profile;
  const AppDrawer({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: LoadingLayer(
          child: Column(
            children: [
              ListTile(
                title: const Text(Labels.aboutUs),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutPage.route);
                },
              ),
              ListTile(
                title: const Text(Labels.dIRECTORBOARD),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, BoardPage.route);
                },
              ),
              ListTile(
                title: const Text(Labels.gallary),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, GallaryPage.route);
                },
              ),
              ListTile(
                title: const Text(Labels.jalgav),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, JalgavPage.route);
                },
              ),
              ListTile(
                title: const Text(Labels.contactUs),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ContactPage.route);
                },
              ),
              ListTile(
                title: const Text(Labels.advertisements),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AdsPage.route);
                },
              ),
              profile.role == Role.admin
                  ? ListTile(
                      title: const Text('Admin List'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AdminList.route);
                      },
                    )
                  : const SizedBox(),
              profile.role == Role.admin
                  ? ListTile(
                      title: const Text('Download Profiles'),
                      onTap: () async {
                        try {
                          var status = await Permission.storage.status;
                          if (!status.isGranted) {
                            await Permission.storage.request();
                          }
                          final loading = ref.read(loadingProvider);
                          loading.start();
                          final response = await http
                              .get(Uri.parse(CloudFunctionApi.prodExcel));
                          if (response.statusCode == 200) {
                            ref.watch(excelFutureProvider).value;
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                            AppSnackbar(context).message("Saved to Downloads");
                          }
                          loading.stop();
                        } catch (e) {}
                      },
                    )
                  : const SizedBox(),
              const Spacer(),
              const Text('App Version:v1.0.${AppVersionCode.versionCode}')
            ],
          ),
        ),
      ),
    );
  }
}
