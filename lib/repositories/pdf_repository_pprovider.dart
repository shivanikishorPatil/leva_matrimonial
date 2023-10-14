import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

final pdfRepoProvider = Provider((ref) => PDFRepositoryProvider());

class PDFRepositoryProvider {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> checkPDF(String uid) async {
    return await _firestore
        .collection('pdfs')
        .doc(uid)
        .get()
        .then((value) => value.exists ? value.data()!['url'] : null);
  }

  static final Random random = Random();

  DownloadTask downloadPDF(String url, String name) {
    String now = DateFormat.jm().format(DateTime.now()).toString();
    Reference ref = _storage.refFromURL(url);
    final file =
        File("/storage/emulated/0/Download/$name marriage resume$now.pdf");
    return ref.writeToFile(file);
  }

  Future<String> downloadFile(String url, String filename) async {
    print("url: $url");
    var dio = Dio();
    var dirloc = "";
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }

    var randid = random.nextInt(10000);

    try {
      FileUtils.mkdir([dirloc]);
      await dio.download(
        url,
        "$dirloc$filename  marriage resume -$randid.pdf",
        onReceiveProgress: (receivedBytes, totalBytes) {},
      );
      return "$dirloc$filename  marriage resume -$randid.pdf";
    } catch (e) {
      debugPrint("$e");
      return Future.error(e);
    }
  }
}
