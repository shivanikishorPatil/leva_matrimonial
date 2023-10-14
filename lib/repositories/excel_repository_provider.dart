import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final excelFutureProvider = FutureProvider((ref) async {
  return ref.watch(excelProvider).downloadExcel();
});

final excelProvider = Provider((ref) {
  return ExcelRepositoryProvider();
});

class ExcelRepositoryProvider {
  static final Random random = Random();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  static const testExcel =
      'gs://leva-matrimonial-test.appspot.com/sheets/userPlusProfileReports.xlsx';
  static const prodExcel =
      'gs://leva-matrimonial---dev.appspot.com/sheets/userPlusProfileReports.xlsx';

  DownloadTask downloadExcel() {
    var randid = random.nextInt(10000);
    Reference ref = _storage.refFromURL(prodExcel);
    final file = File(
        "/storage/emulated/0/Download/Leva Matrimonial Profiles-$randid.xlsx");
    return ref.writeToFile(file);
  }

  // Future<String> downloadExcel() async {
  //   var dio = Dio();
  //   var dirloc = "";
  //   if (Platform.isAndroid) {
  //     dirloc = "/sdcard/download/";
  //   } else {
  //     dirloc = (await getApplicationDocumentsDirectory()).path;
  //   }

  //   var randid = random.nextInt(10000);

  //   try {
  //     FileUtils.mkdir([dirloc]);
  //     await dio.download(
  //       testExcel,
  //       "$dirloc Leva Matrimonial Profiles-$randid.xlsx",
  //       onReceiveProgress: (receivedBytes, totalBytes) {},
  //     );
  //     return "$dirloc Leva Matrimonial Profiles-$randid.xlsx";
  //   } catch (e) {
  //     debugPrint("$e");
  //     return Future.error(e);
  //   }
  // }
}
