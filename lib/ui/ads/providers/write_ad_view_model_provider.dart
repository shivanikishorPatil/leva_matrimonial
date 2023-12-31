import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/models/ad.dart';
import 'package:leva_matrimonial/repositories/ad_repository_provider.dart';

import '../../providers/loading_provider.dart';

final writeAdViewModelProvider =
    ChangeNotifierProvider((ref) => WriteItemViewModel(ref.read));

class WriteItemViewModel extends ChangeNotifier {
  final  _reader;

  WriteItemViewModel(this._reader);

  Ad? _initial;
  Ad get initial =>
      _initial ??
      Ad.empty().copyWith(
        createdAt: DateTime.now(),
      );
  set initial(Ad initial) {
    _initial = initial;
  }

  String? get image => initial.image;

  bool get edit => initial.id.isNotEmpty;

  String? _title;
  String get title => _title ?? initial.title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String? _description;
  String get description => _description ?? initial.description;
  set description(String description) {
    _description = description;
    notifyListeners();
  }

  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  bool get enabled =>
      title.isNotEmpty &&
      description.isNotEmpty;

  Loading get _loading => _reader(loadingProvider);

  AdRepository get _repository => _reader(adsRepositoryProvider);

  Future<void> write() async {
    final updated = initial.copyWith(
      title: title,
      description: description,
    );
    _loading.start();
    try {
      await _repository.writeItem(updated, file: file);
      _loading.stop();
    } catch (e) {
      _loading.end();
      return Future.error("Something error!");
    }
  }

  void clear() {
    _initial = null;
    _title = null;
    _description = null;
    _file = null;
  }
}
