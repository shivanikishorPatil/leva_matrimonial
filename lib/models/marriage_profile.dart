import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:leva_matrimonial/enums/gender.dart';
import 'package:leva_matrimonial/enums/marital_status.dart';
import 'package:leva_matrimonial/enums/status.dart';
import 'package:leva_matrimonial/utils/data.dart';

import '../utils/dates.dart';

class MarriageProfile {
  final String id;
  final Status status;
  final String? image;
  final String? thumbnail;
  final int regNo;
  final MaritalStatus? maritalStatus;
  final String fname;
  final String mname;
  final String lname;
  final String fnameM;
  final String mnameM;
  final String lnameM;
  final String birthName;
  final DateTime birth;
  final String birthPlace;
  final String height;
  final String gotr;
  final String varn;
  final Gender? gender;
  final int unmarriedSisters;
  final int unmarriedBrothers;
  final int marriedSisters;
  final int marriedBrothers;

  final String originalFrom;
  final String taluka;
  final String district;

  final String education;
  final String eduCategory;
  final String? job;
  final String? company;
  final String? jobPlace;
  final int? salary;
  final String expectation;
  // final String ffatherName;
  // final String mfatherName;
  // final String lfatherName;
  final String ffatherNameM;
  final String mfatherNameM;
  final String lfatherNameM;
  final String fatherAddress;
  final String fatherDesignation;
  final String fatherMobile1;
  final String? fatherMobile2;
  final String? fcontactName1;
  final String? mcontactName1;
  final String? lcontactName1;
  final String? contact1;
  final String? contact1city;
  final String? fcontactName2;
  final String? mcontactName2;
  final String? lcontactName2;
  final String? contact2;
  final String? contact2city;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String filledBy;
  MarriageProfile({
    required this.id,
    required this.status,
    required this.regNo,
    this.image,
    this.thumbnail,
    required this.maritalStatus,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.fnameM,
    required this.fatherDesignation,
    required this.fatherAddress,
    required this.mnameM,
    required this.unmarriedSisters,
    required this.unmarriedBrothers,
    required this.marriedBrothers,
    required this.marriedSisters,
    required this.lnameM,
    required this.birthName,
    required this.birth,
    required this.birthPlace,
    required this.height,
    required this.gotr,
    required this.varn,
    required this.gender,
    required this.education,
    required this.eduCategory,
    this.job,
    this.company,
    this.jobPlace,
    this.salary,
    required this.expectation,
    // required this.ffatherName,
    // required this.mfatherName,
    // required this.lfatherName,
    required this.ffatherNameM,
    required this.mfatherNameM,
    required this.lfatherNameM,
    required this.fatherMobile1,
    required this.originalFrom,
    required this.taluka,
    required this.district,
    this.fatherMobile2,
    this.fcontactName1,
    this.mcontactName1,
    this.lcontactName1,
    this.contact1,
    this.contact1city,
    this.fcontactName2,
    this.mcontactName2,
    this.lcontactName2,
    this.contact2,
    this.contact2city,
    required this.createdAt,
    this.updatedAt,
    required this.filledBy,
  });

  MarriageProfile copyWith({
    bool only = false,
    int? regNo,
    String? id,
    Status? status,
    String? image,
    String? thumbnail,
    MaritalStatus? maritalStatus,
    String? fname,
    String? mname,
    String? lname,
    String? fnameM,
    String? mnameM,
    String? lnameM,
    String? birthName,
    DateTime? birth,
    String? birthPlace,
    String? height,
    String? gotr,
    String? originalFrom,
    String? taluka,
    String? district,
    String? varn,
    String? education,
    String? eduCategory,
    String? job,
    String? fatherAddress,
    String? fatherDesignation,
    String? company,
    String? jobPlace,
    int? salary,
    String? expectation,
    // String? ffatherName,
    // String? mfatherName,
    // String? lfatherName,
    String? ffatherNameM,
    String? mfatherNameM,
    String? lfatherNameM,
    String? fatherMobile1,
    String? fatherMobile2,
    String? fcontactName1,
    String? mcontactName1,
    String? lcontactName1,
    String? contact1,
    String? contact1city,
    String? fcontactName2,
    String? mcontactName2,
    String? lcontactName2,
    String? contact2,
    String? contact2city,
    DateTime? createdAt,
    DateTime? updatedAt,
    Gender? gender,
    int? unmarriedSisters,
    int? unmarriedBrothers,
    int? marriedSisters,
    int? marriedBrothers,
    String? filledBy,
  }) {
    return MarriageProfile(
      id: id ?? this.id,
      regNo: regNo ?? this.regNo,
      marriedBrothers: marriedBrothers ?? this.marriedBrothers,
      marriedSisters: marriedSisters ?? this.marriedSisters,
      status: status ?? this.status,
      image: image ?? this.image,
      thumbnail: thumbnail ?? this.thumbnail,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      fname: fname ?? this.fname,
      mname: mname ?? this.mname,
      lname: lname ?? this.lname,
      fnameM: fnameM ?? this.fnameM,
      mnameM: mnameM ?? this.mnameM,
      lnameM: lnameM ?? this.lnameM,
      district: district ?? this.district,
      originalFrom: originalFrom ?? this.originalFrom,
      taluka: taluka ?? this.taluka,
      birthName: birthName ?? this.birthName,
      birth: birth ?? this.birth,
      birthPlace: birthPlace ?? this.birthPlace,
      height: height ?? this.height,
      gotr: gotr ?? this.gotr,
      fatherAddress: fatherAddress ?? this.fatherAddress,
      fatherDesignation: fatherDesignation ?? this.fatherDesignation,
      varn: varn ?? this.varn,
      education: education ?? this.education,
      eduCategory: eduCategory ?? this.eduCategory,
      job: only ? this.job : job,
      company: only ? this.company : company,
      jobPlace: only ? this.jobPlace : jobPlace,
      salary: only ? this.salary : salary,
      expectation: expectation ?? this.expectation,
      ffatherNameM: ffatherNameM ?? this.ffatherNameM,
      mfatherNameM: mfatherNameM ?? this.mfatherNameM,
      lfatherNameM: lfatherNameM ?? this.lfatherNameM,
      fatherMobile1: fatherMobile1 ?? this.fatherMobile1,
      fatherMobile2: only ? this.fatherMobile2 : fatherMobile2,
      fcontactName1: only ? this.fcontactName1 : fcontactName1,
      mcontactName1: only ? this.mcontactName1 : mcontactName1,
      lcontactName1: only ? this.lcontactName1 : lcontactName1,
      contact1: only ? this.contact1 : contact1,
      contact1city: only ? this.contact1city : contact1city,
      fcontactName2: only ? this.fcontactName2 : fcontactName2,
      mcontactName2: only ? this.mcontactName2 : mcontactName2,
      lcontactName2: only ? this.lcontactName2 : lcontactName2,
      contact2: only ? this.contact2 : contact2,
      contact2city: only ? this.contact2city : contact2city,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
      unmarriedBrothers: unmarriedBrothers ?? this.unmarriedBrothers,
      unmarriedSisters: unmarriedSisters ?? this.unmarriedSisters,
      filledBy: filledBy ?? this.filledBy,
    );
  }

  List<String> _keys(String name) {
    List<String> values = [];
    String initValue = "";
    for (var item in name.toLowerCase().split("")) {
      initValue = initValue + item;
      values.add(initValue);
    }
    return values;
  }

  List<String> get keys => (_keys(fname) +
          _keys(
            lname,
          ))
      .toSet()
      .toList();

  Map<String, dynamic> toMap() {
    print(contactName1);
    return {
      'regNo': regNo,
      'status': status == Status.approved ? Status.pending.name : status.name,
      'image': image,
      'thumbnail': thumbnail,
      'maritalStatus': maritalStatus!.name,
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'fnameM': fnameM,
      'mnameM': mnameM,
      'lnameM': lnameM,
      'birthName': birthName,
      'birth': birth,
      'birthPlace': birthPlace,
      'height': height,
      'gotr': gotr,
      'varn': varn,
      'education': education,
      'eduCategory': eduCategory,
      'job': job,
      'company': company,
      'jobPlace': jobPlace,
      'salary': salary,
      'expectation': expectation,
      // 'ffatherName': ffatherName,
      // 'mfatherName': mfatherName,
      // 'lfatherName': lfatherName,
      'fatherAddress': fatherAddress,
      'fatherDesignation': fatherDesignation,
      'ffatherNameM': ffatherNameM,
      'mfatherNameM': mfatherNameM,
      'lfatherNameM': lfatherNameM,
      'fatherMobile1': fatherMobile1,
      'fatherMobile2': fatherMobile2,
      'fcontactName1': fcontactName1,
      'mcontactName1': mcontactName1,
      'lcontactName1': lcontactName1,
      'contact1': contact1,
      'contact1city': contact1city,
      'district': district,
      'originalFrom': originalFrom,
      'taluka': taluka,
      'fcontactName2': fcontactName2,
      'mcontactName2': mcontactName2,
      'lcontactName2': lcontactName2,
      'contact2': contact2,
      'contact2city': contact2city,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'gender': gender!.name,
      'unmarriedSisters': unmarriedSisters,
      'unmarriedBrothers': unmarriedBrothers,
      'marriedBrothers': marriedBrothers,
      'marriedSisters': marriedSisters,
      'hr': hr,
      'keys': keys,
      'filledBy': filledBy,
    };
  }

  int get hr => Data.heightRanges.indexOf(
        Data.heightRanges.where((element) => element.contains(height)).first,
      );

  bool get needProfessionalDetails =>
      education.isEmpty || eduCategory.isEmpty || expectation.isEmpty;

  bool get needFamilyDetails =>
      ffatherNameM.isEmpty || mfatherNameM.isEmpty || lfatherNameM.isEmpty;

  factory MarriageProfile.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return MarriageProfile(
      regNo: map['regNo'] ?? 0,
      id: doc.id,
      status: Status.values
          .where(
            (e) => e.name == map['status'],
          )
          .first,
      gender: Gender.values
          .where(
            (e) => e.name == map['gender'],
          )
          .first,
      unmarriedBrothers: map['unmarriedBrothers'] ?? map['noofBrothers'] ?? 0,
      unmarriedSisters: map['unmarriedSisters'] ?? map['noofSisters'] ?? 0,
      image: map['image'],
      thumbnail: map['thumbnail'],
      maritalStatus: map['maritalStatus'] == null
          ? MaritalStatus.notmarried
          : MaritalStatus.values
              .where((element) => element.name == map['maritalStatus'])
              .first,
      fname: map['fname'] ?? '',
      mname: map['mname'] ?? '',
      lname: map['lname'] ?? '',
      fnameM: map['fnameM'] ?? '',
      mnameM: map['mnameM'] ?? '',
      lnameM: map['lnameM'] ?? '',

      district: map['district'] ?? '',
      originalFrom: map['originalFrom'] ?? '',
      taluka: map['taluka'] ?? '',
      fatherAddress: map['fatherAddress'] ?? '',
      fatherDesignation: map['fatherDesignation'] ?? '',
      birthName: map['birthName'] ?? '',
      birth: map['birth'].toDate(),
      birthPlace: map['birthPlace'] ?? '',
      height: map['height'] ?? "",
      gotr: map['gotr'] ?? '',
      varn: map['varn'] ?? '',
      education: map['education'] ?? '',
      eduCategory: map['eduCategory'] ?? '',
      job: map['job'],
      company: map['company'],
      jobPlace: map['jobPlace'],
      salary: map['salary']?.toInt(),
      expectation: map['expectation'] ?? '',
      // ffatherName: map['ffatherName'] ?? '',
      // mfatherName: map['mfatherName'] ?? '',
      // lfatherName: map['lfatherName'] ?? '',
      ffatherNameM: map['ffatherNameM'] ?? '',
      mfatherNameM: map['mfatherNameM'] ?? '',
      lfatherNameM: map['lfatherNameM'] ?? '',
      fatherMobile1: map['fatherMobile1'] ?? '',
      fatherMobile2: map['fatherMobile2'],
      fcontactName1: map['fcontactName1'],
      mcontactName1: map['mcontactName1'],
      lcontactName1: map['lcontactName1'],
      contact1: map['contact1'],
      contact1city: map['contact1city'],
      fcontactName2: map['fcontactName2'],
      mcontactName2: map['mcontactName2'],
      lcontactName2: map['lcontactName2'],
      contact2: map['contact2'],
      contact2city: map['contact2city'],
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt']?.toDate(),
      filledBy: map['filledBy'] ?? '',
      marriedSisters: map['marriedSisters'] ?? 0,
      marriedBrothers: map['marriedBrothers'] ?? 0,
    );
  }

  String get name => "$fname $mname $lname";
  String get nameM => "$fnameM $mnameM $lnameM";
  // String get fatherName => "$ffatherName $mfatherName $lfatherName";
  String get fatherNameM => "$ffatherNameM $mfatherNameM $lfatherNameM";
  String get contactName1 => "$fcontactName1 $mcontactName1 $lcontactName1";
  String get contactName2 => "$fcontactName2 $mcontactName2 $lcontactName2";

  String get ageLabel => "${Dates.today.difference(birth).inDays ~/ 365}+";

  factory MarriageProfile.empty() => MarriageProfile(
        regNo: 0,
        id: '',
        status: Status.draft,
        maritalStatus: null,
        gender: null,
        birthName: '',
        birth: DateTime(1900),
        birthPlace: '',
        height: '',
        gotr: '',
        varn: '',
        education: '',
        eduCategory: '',
        expectation: '',
        district: '',
        originalFrom: '',
        taluka: '',
        fatherMobile1: '',
        createdAt: DateTime.now(),
        unmarriedBrothers: 0,
        unmarriedSisters: 0,
        fname: '',
        lname: '',
        fatherAddress: '',
        fatherDesignation: '',
        mname: '',
        ffatherNameM: '',
        fnameM: '',
        lfatherNameM: '',
        lnameM: '',
        mfatherNameM: '',
        mnameM: '',
        filledBy: '',
        marriedBrothers: 0,
        marriedSisters: 0,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarriageProfile && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  String toString() {
    return 'MarriageProfile(id: $id, status: $status, image: $image, thumbnail: $thumbnail, regNo: $regNo, maritalStatus: $maritalStatus, fname: $fname, mname: $mname, lname: $lname, fnameM: $fnameM, mnameM: $mnameM, lnameM: $lnameM, birthName: $birthName, birth: $birth, birthPlace: $birthPlace, height: $height, gotr: $gotr, varn: $varn, gender: $gender, unmarriedSisters: $unmarriedSisters, unmarriedBrothers: $unmarriedBrothers, marriedSisters: $marriedSisters, marriedBrothers: $marriedBrothers, originalFrom: $originalFrom, taluka: $taluka, district: $district, education: $education, eduCategory: $eduCategory, job: $job, company: $company, jobPlace: $jobPlace, salary: $salary, expectation: $expectation, ffatherNameM: $ffatherNameM, mfatherNameM: $mfatherNameM, lfatherNameM: $lfatherNameM, fatherAddress: $fatherAddress, fatherDesignation: $fatherDesignation, fatherMobile1: $fatherMobile1, fatherMobile2: $fatherMobile2, fcontactName1: $fcontactName1, mcontactName1: $mcontactName1, lcontactName1: $lcontactName1, contact1: $contact1, contact1city: $contact1city, fcontactName2: $fcontactName2, mcontactName2: $mcontactName2, lcontactName2: $lcontactName2, contact2: $contact2, contact2city: $contact2city, createdAt: $createdAt, updatedAt: $updatedAt, filledBy: $filledBy)';
  }
}
