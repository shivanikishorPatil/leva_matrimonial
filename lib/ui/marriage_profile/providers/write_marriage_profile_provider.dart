import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/marital_status.dart';
import 'package:leva_matrimonial/models/marriage_profile.dart';
import 'package:leva_matrimonial/repositories/marriage_profile_repository_provider.dart';
import 'package:leva_matrimonial/ui/profile/providers/profile_provider.dart';

import '../../../models/profile.dart';
import '../../providers/loading_provider.dart';

final writeMarriageProfileProvider =
    ChangeNotifierProvider<WriteMarriageProfileViewModel>((ref) {
  Profile user = ref.read(profileProvider).value!;
  final model = WriteMarriageProfileViewModel(ref.read);
  model.initial = MarriageProfile.empty().copyWith(
    id: user.id,
  );
  return model;
});

class WriteMarriageProfileViewModel extends ChangeNotifier {
  final  _reader;
  WriteMarriageProfileViewModel(this._reader);

  // bool get edit => initial.image.isNotEmpty;

  late MarriageProfile _initial;

  MarriageProfile get initial => _initial;

  set initial(MarriageProfile initial) {
    _initial = initial;
    fatherMobile2 = initial.fatherMobile2;
    _fcontactName1 = initial.fcontactName1;
    _mcontactName1 = initial.mcontactName1;
    _lcontactName1 = initial.lcontactName1;
    _contact1city = initial.contact1city;
    _contact1 = initial.contact1;
    _fcontactName2 = initial.fcontactName2;
    _mcontactName2 = initial.mcontactName2;
    _lcontactName2 = initial.lcontactName2;
    _contact2city = initial.contact2city;
    _contact2 = initial.contact2;
    _job = initial.job;
    _company = initial.company;
    _jobPlace = initial.jobPlace;
    _salary = initial.salary;
  }

  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  String? get image => initial.image;

  String? _fname;
  String get fname => _fname ?? initial.fname;
  set fname(String fname) {
    _fname = fname;
  }

  String? _mname;
  String get mname => _mname ?? initial.mname;
  set mname(String mname) {
    _mname = mname;
  }

  String? _lname;
  String get lname => _lname ?? initial.lname;
  set lname(String lname) {
    _lname = lname;
  }

  String? _fnameM;
  String get fnameM => _fnameM ?? initial.fnameM;
  set fnameM(String fnameM) {
    _fnameM = fnameM;
  }

  String? _mnameM;
  String get mnameM => _mnameM ?? initial.mnameM;
  set mnameM(String mnameM) {
    _mnameM = mnameM;
  }

  String? _lnameM;
  String get lnameM => _lnameM ?? initial.lnameM;
  set lnameM(String lnameM) {
    _lnameM = lnameM;
  }

  String? _birthName;
  String get birthName => _birthName ?? initial.birthName;
  set birthName(String birthName) {
    _birthName = birthName;
  }

  DateTime? _birth;
  DateTime? get birth =>
      _birth ?? (initial.birth.year == 1900 ? null : initial.birth);
  set birth(DateTime? birth) {
    _birth = birth;
    notifyListeners();
  }

  String? _birthPlace;
  String get birthPlace => _birthPlace ?? initial.birthPlace;
  set birthPlace(String birthPlace) {
    _birthPlace = birthPlace;
  }

  String? _height;
  String get height => _height ?? initial.height;
  set height(String height) {
    _height = height;
  }

  String? _gotr;
  String get gotr => _gotr ?? initial.gotr;
  set gotr(String gotr) {
    _gotr = gotr;
  }

  String? _varn;
  String get varn => _varn ?? initial.varn;
  set varn(String varn) {
    _varn = varn;
  }

  String? _originalFrom;
  String get originalFrom => _originalFrom ?? initial.originalFrom;
  set originalFrom(String originalFrom) {
    _originalFrom = originalFrom;
  }

  String? _taluka;
  String get taluka => _taluka ?? initial.taluka;
  set taluka(String taluka) {
    _taluka = taluka;
  }

  String? _district;
  String get district => _district ?? initial.district;
  set district(String district) {
    _district = district;
  }

  Gender? _gender;
  Gender? get gender => _gender ?? initial.gender;
  set gender(Gender? gender) {
    _gender = gender;
    notifyListeners();
  }

  MaritalStatus? _maritalStatus;
  MaritalStatus? get maritalStatus => _maritalStatus ?? initial.maritalStatus;
  set maritalStatus(MaritalStatus? maritalStatus) {
    _maritalStatus = maritalStatus;
    notifyListeners();
  }

  int? _unmarriedSisters;
  int get unmarriedSisters => _unmarriedSisters ?? initial.unmarriedSisters;
  set unmarriedSisters(int noofSisters) {
    _unmarriedSisters = noofSisters;
    notifyListeners();
  }

  int? _unmarriedBrothers;
  int get unmarriedBrothers => _unmarriedBrothers ?? initial.unmarriedBrothers;
  set unmarriedBrothers(int noofBrothers) {
    _unmarriedBrothers = noofBrothers;
    notifyListeners();
  }

  int? _marriedBrothers;
  int get marriedBrothers => _marriedBrothers ?? initial.marriedBrothers;
  set marriedBrothers(int marriedBrothers) {
    _marriedBrothers = marriedBrothers;
    notifyListeners();
  }

  int? _marriedSisters;
  int get marriedSisters => _marriedSisters ?? initial.marriedSisters;
  set marriedSisters(int marriedSisters) {
    _marriedSisters = marriedSisters;
    notifyListeners();
  }

  bool get enabled1 =>
      fname.isNotEmpty &&
      mname.isNotEmpty &&
      lname.isNotEmpty &&
      fnameM.isNotEmpty &&
      mnameM.isNotEmpty &&
      lnameM.isNotEmpty &&
      birthName.isNotEmpty &&
      birth != null &&
      birthPlace.isNotEmpty &&
      height.isNotEmpty &&
      gotr.isNotEmpty &&
      varn.isNotEmpty;

  String? _education;
  String get education => _education ?? initial.education;
  set education(String education) {
    _education = education;
  }

  String? _eduCategory;
  String get eduCategory => _eduCategory ?? initial.eduCategory;
  set eduCategory(String eduCategory) {
    _eduCategory = eduCategory;
  }

  String? _job;
  String? get job => _job;
  set job(String? job) {
    _job = job;
    notifyListeners();
  }

  String? _company;
  String? get company => _company;
  set company(String? company) {
    _company = company;
    notifyListeners();
  }

  String? _jobPlace;
  String? get jobPlace => _jobPlace;
  set jobPlace(String? jobPlace) {
    _jobPlace = jobPlace;
    notifyListeners();
  }

  int? _salary;
  int? get salary => _salary;
  set salary(int? salary) {
    _salary = salary;
    notifyListeners();
  }

  String? _expectation;
  String get expectation => _expectation ?? initial.expectation;
  set expectation(String expectation) {
    _expectation = expectation;
  }

  bool get needJobDetails =>
      job != null || company != null || jobPlace != null || salary != null;

  bool get enabled2 {
    notifyListeners();
    return education.isNotEmpty &&
        eduCategory.isNotEmpty &&
        (needJobDetails
            ? job != null &&
                company != null &&
                jobPlace != null &&
                salary != null
            : true) &&
        expectation.isNotEmpty;
  }

  // String? _ffatherName;
  // String get ffatherName => _ffatherName ?? initial.ffatherName;
  // set ffatherName(String ffatherName) {
  //   _ffatherName = ffatherName;
  // }

  // String? _mfatherName;
  // String get mfatherName => _mfatherName ?? initial.mfatherName;
  // set mfatherName(String mfatherName) {
  //   _mfatherName = mfatherName;
  // }

  // String? _lfatherName;
  // String get lfatherName => _lfatherName ?? initial.lfatherName;
  // set lfatherName(String lfatherName) {
  //   _lfatherName = lfatherName;
  // }

  String? _ffatherNameM;
  String get ffatherNameM => _ffatherNameM ?? initial.ffatherNameM;
  set ffatherNameM(String ffatherNameM) {
    _ffatherNameM = ffatherNameM;
  }

  String? _fatherAddress;
  String get fatherAddress => _fatherAddress ?? initial.fatherAddress;
  set fatherAddress(String fatherAddress) {
    _fatherAddress = fatherAddress;
  }

  String? _fatherDesignation;
  String get fatherDesignation =>
      _fatherDesignation ?? initial.fatherDesignation;
  set fatherDesignation(String fatherDesignation) {
    _fatherDesignation = fatherDesignation;
  }

  String? _mfatherNameM;
  String get mfatherNameM => _mfatherNameM ?? initial.mfatherNameM;
  set mfatherNameM(String mfatherNameM) {
    _mfatherNameM = mfatherNameM;
    notifyListeners();
  }

  String? _lfatherNameM;
  String get lfatherNameM => _lfatherNameM ?? initial.lfatherNameM;
  set lfatherNameM(String lfatherNameM) {
    _lfatherNameM = lfatherNameM;
    notifyListeners();
  }

  String? _fatherMobile1;
  String get fatherMobile1 => _fatherMobile1 ?? initial.fatherMobile1;
  set fatherMobile1(String fatherMobile1) {
    _fatherMobile1 = fatherMobile1;
    notifyListeners();
  }

  String? _fatherMobile2;
  String? get fatherMobile2 => _fatherMobile2;
  set fatherMobile2(String? fatherMobile2) {
    _fatherMobile2 = fatherMobile2;
    notifyListeners();
  }

  String? _fcontactName1;
  String? get fcontactName1 => _fcontactName1;
  set fcontactName1(String? fcontactName1) {
    _fcontactName1 = fcontactName1;
    notifyListeners();
  }

  String? _mcontactName1;
  String? get mcontactName1 => _mcontactName1;
  set mcontactName1(String? mcontactName1) {
    _mcontactName1 = mcontactName1;
    notifyListeners();
  }

  String? _lcontactName1;
  String? get lcontactName1 => _lcontactName1;
  set lcontactName1(String? lcontactName1) {
    _lcontactName1 = lcontactName1;
    notifyListeners();
  }

  String? _contact1;
  String? get contact1 => _contact1;
  set contact1(String? contact1) {
    _contact1 = contact1;
    notifyListeners();
  }

  String? _contact1city;
  String? get contact1city => _contact1city;
  set contact1city(String? contact1city) {
    _contact1city = contact1city;
    notifyListeners();
  }

  bool get needContact1 =>
      fcontactName1 != null ||
      mcontactName1 != null ||
      lcontactName1 != null ||
      contact1 != null ||
      contact1city != null;

  String? _contact2;
  String? get contact2 => _contact2;
  set contact2(String? contact2) {
    _contact2 = contact2;
    notifyListeners();
  }

  String? _fcontactName2;
  String? get fcontactName2 => _fcontactName2;
  set fcontactName2(String? fcontactName2) {
    _fcontactName2 = fcontactName2;
    notifyListeners();
  }

  String? _mcontactName2;
  String? get mcontactName2 => _mcontactName2;
  set mcontactName2(String? mcontactName2) {
    _mcontactName2 = mcontactName2;
    notifyListeners();
  }

  String? _lcontactName2;
  String? get lcontactName2 => _lcontactName2;
  set lcontactName2(String? lcontactName2) {
    _lcontactName2 = lcontactName2;
    notifyListeners();
  }

  String? _contact2city;
  String? get contact2city => _contact2city;
  set contact2city(String? contact2city) {
    _contact2city = contact2city;
    notifyListeners();
  }

  bool get needContact2 =>
      fcontactName2 != null ||
      mcontactName2 != null ||
      lcontactName2 != null ||
      contact2 != null ||
      contact2city != null;

  bool get enabled3 =>
      ffatherNameM.isNotEmpty &&
      mfatherNameM.isNotEmpty &&
      lfatherNameM.isNotEmpty &&
      fatherMobile1.length == 10 &&
      (needContact1
          ? fcontactName1 != null &&
              mcontactName1 != null &&
              lcontactName1 != null &&
              contact1 != null &&
              contact1!.length == 10
          : true) &&
      (needContact2
          ? fcontactName2 != null &&
              mcontactName2 != null &&
              lcontactName2 != null &&
              contact2 != null &&
              contact2!.length == 10
          : true);

  String _filledBy = '';
  String get filledBy => _filledBy;
  set filledBy(String filledBy) {
    _filledBy = filledBy;
    notifyListeners();
  }

  void setState() {
    notifyListeners();
  }

  bool _terms = false;
  bool get terms => _terms;
  set terms(bool terms) {
    _terms = terms;
    notifyListeners();
  }

  List<bool> get enabled => [enabled1, enabled2, enabled3, true];

  Loading get _loading => _reader(loadingProvider);

  Future<File> compress(String path) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(path);
    File compressedFile = await FlutterNativeImage.compressImage(path,
        quality: 100,
        targetWidth: 500,
        targetHeight:
            ((properties.height ?? 1) * 500 / (properties.width ?? 1)).round());
    return compressedFile;
  }

  Future<void> writeProfile() async {
    final updated = initial.copyWith(
      fname: fname,
      lname: lname,
      mname: mname,
      fnameM: fnameM,
      lnameM: lnameM,
      mnameM: mnameM,
      district: district,
      originalFrom: originalFrom,
      taluka: taluka,
      birthName: birthName,
      birth: birth,
      birthPlace: birthPlace,
      gotr: gotr,
      varn: varn,
      company: company,
      contact1: contact1,
      contact2: contact2,
      fcontactName1: fcontactName1,
      mcontactName1: mcontactName1,
      lcontactName1: lcontactName1,
      fcontactName2: fcontactName2,
      mcontactName2: mcontactName2,
      lcontactName2: lcontactName2,
      eduCategory: eduCategory,
      createdAt: DateTime.now(),
      education: education,
      expectation: expectation,
      fatherMobile1: fatherMobile1,
      fatherMobile2: fatherMobile2,
      ffatherNameM: ffatherNameM,
      mfatherNameM: mfatherNameM,
      lfatherNameM: lfatherNameM,
      fatherAddress: fatherAddress,
      maritalStatus: maritalStatus,
      fatherDesignation: fatherDesignation,
      height: height,
      job: job,
      jobPlace: jobPlace,
      salary: salary,
      unmarriedBrothers: unmarriedBrothers,
      unmarriedSisters: unmarriedSisters,
      contact1city: contact1city,
      contact2city: contact2city,
      filledBy: filledBy,
      marriedBrothers: marriedBrothers,
      marriedSisters: marriedSisters,
      gender: gender,
    );
    _loading.start();
    try {
      File? thumb;
      if (file != null) {
        thumb = await compress(file!.path);
      }
      await _reader(marriageProfileRepositoryProvider)
          .write(updated, file: file, thumbnail: thumb);
      _loading.stop();
    } catch (e) {
      debugPrint(e.toString());
      _loading.stop();
      return Future.error("$e");
    }
  }

  void clear() {
    _file = null;
    _birth = null;
    _birthName = null;
    _birthPlace = null;
    _company = null;
    _contact1 = null;
    _contact1city = null;
    _contact2 = null;
    _contact2city = null;
    _district = null;
    _eduCategory = null;
    _education = null;
    _expectation = null;
    _gender = null;
    _gotr = null;
    _height = null;
    _fatherAddress = null;
    _fatherDesignation = null;
    _fatherMobile1 = null;
    _fatherMobile2 = null;
    _fcontactName1 = null;
    _fcontactName2 = null;
    _ffatherNameM = null;
    _fname = null;
    _fnameM = null;
    _lfatherNameM = null;
    _lcontactName1 = null;
    _lcontactName2 = null;
    _lname = null;
    _lnameM = null;
    _maritalStatus = null;
    _marriedBrothers = null;
    _marriedSisters = null;
    _mcontactName1 = null;
    _mcontactName2 = null;
    _mfatherNameM = null;
    _mname = null;
    _mnameM = null;
    _originalFrom = null;
    _job = null;
    _jobPlace = null;
    _salary = null;
    _taluka = null;
    _unmarriedBrothers = null;
    _unmarriedSisters = null;
    _varn = null;
  }
}
