import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/models/debouncer.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';

import '../../../models/params.dart';
import '../../../utils/dates.dart';

final itemsViewModelProvider =
    ChangeNotifierProvider.family<ItemsViewModel, Params>((ref, param) {
  final model = ItemsViewModel(ref.read, param.gender, param.status);
  model.initSearch();
  model.init();
  return model;
});

class ItemsViewModel extends ChangeNotifier {
  final  _reader;
  final Gender gender;
  final Status status;
  ItemsViewModel(this._reader, this.gender, this.status);

  MarriageProfileRepository get _repository =>
      _reader(marriageProfileRepositoryProvider);

  final List<DocumentSnapshot> _itemsDocs = [];

  List<MarriageProfile> profiles(List<MarriageProfile> pr) {
    return pr.where((element) {
      if (ageRange != null) {
        final minBirth = DateTime(Dates.today.year - ageRange!.end.toInt(),
            Dates.today.month, Dates.today.day);
        final maxBirth = DateTime(Dates.today.year - ageRange!.start.toInt(),
            Dates.today.month, Dates.today.day);
        return (element.birth.isBefore(maxBirth) ||
                element.birth == maxBirth) &&
            (element.birth.isAfter(minBirth) || element.birth == minBirth);
      } else {
        return true;
      }
    }).toList();
  }

  List<MarriageProfile> get items => profiles(
      _itemsDocs.map((e) => MarriageProfile.fromFirestore(e)).toList());

  bool loading = true;
  bool busy = true;

  String? eduCategory;
  int? heightRange;
  final ScrollController scroll = ScrollController();

  int get filterCount => [eduCategory, heightRange, salaryRange, ageRange]
      .where((element) => element != null)
      .length;

  RangeValues? salaryRange;
  RangeValues? ageRange;

  late Debouncer debouncer;

  void initSearch() {
    try {
      debouncer = Debouncer(const Duration(milliseconds: 500), (v) {
        if (!busy) {
          init();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void init() async {
    try {
      if (_itemsDocs.isNotEmpty) {
        _itemsDocs.clear();
        busy = true;
        notifyListeners();
      }
      _itemsDocs.clear();
      _itemsDocs.addAll(await _repository.paginateProfiles(
        limit: 10,
        status: status,
        gender: gender,
        eduCategory: eduCategory,
        heightRange: heightRange,
        minSalary: salaryRange?.start.toInt(),
        maxSalary: salaryRange?.end.toInt(),
        maxAge: ageRange?.end.toInt(),
        minAge: ageRange?.start.toInt(),
        key: debouncer.value.toLowerCase(),
      ));
      scroll.addListener(() {
        if (scroll.position.maxScrollExtent == scroll.position.pixels) {
          if(!busy){
            loadMore();
          }
        }
      });
      busy = false;
      notifyListeners();
      print(items.map((e) => e.name).toList());
    } catch (e) {
      debugPrint(e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void loadMore() async {
    busy = true;
    print("Looooood");
    try {
      final moreItemsDocs = await _repository.paginateProfiles(
        limit: 4,
        lastDocument: _itemsDocs.isNotEmpty ? _itemsDocs.last : null,
        gender: gender,
        eduCategory: eduCategory,
        heightRange: heightRange,
        minSalary: salaryRange?.start.toInt(),
        maxSalary: salaryRange?.end.toInt(),
        maxAge: ageRange?.end.toInt(),
        minAge: ageRange?.start.toInt(),
        key: debouncer.value.toLowerCase(),
        status: status,
      );
      _itemsDocs.addAll(moreItemsDocs);
      loading = moreItemsDocs.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    busy = false;
    notifyListeners();
  }
}
