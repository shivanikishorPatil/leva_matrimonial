// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppVersion {
  final bool forceUpdate;
  final bool forceUpdateIOS;
  final int versionNumber;
  final int versionNumberIOS;
  AppVersion({
    required this.forceUpdate,
    required this.forceUpdateIOS,
    required this.versionNumber,
    required this.versionNumberIOS,
  });

  AppVersion copyWith({
    bool? forceUpdate,
    bool? forceUpdateIOS,
    int? versionNumber,
    int? versionNumberIOS,
  }) {
    return AppVersion(
      forceUpdate: forceUpdate ?? this.forceUpdate,
      forceUpdateIOS: forceUpdateIOS ?? this.forceUpdateIOS,
      versionNumber: versionNumber ?? this.versionNumber,
      versionNumberIOS: versionNumberIOS ?? this.versionNumberIOS,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'forceUpdate': forceUpdate,
      'forceUpdateIOS': forceUpdateIOS,
      'versionNumber': versionNumber,
      'versionNumberIOS': versionNumberIOS,
    };
  }

  factory AppVersion.fromMap(Map<String, dynamic> map) {
    return AppVersion(
      forceUpdate: map['forceUpdate'] as bool,
      forceUpdateIOS: map['forceUpdateIOS'] as bool,
      versionNumber: map['versionNumber'] as int,
      versionNumberIOS: map['versionNumberIOS'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppVersion.fromJson(String source) =>
      AppVersion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppVersion(forceUpdate: $forceUpdate, forceUpdateIOS: $forceUpdateIOS, versionNumber: $versionNumber, versionNumberIOS: $versionNumberIOS)';
  }

  @override
  bool operator ==(covariant AppVersion other) {
    if (identical(this, other)) return true;

    return other.forceUpdate == forceUpdate &&
        other.forceUpdateIOS == forceUpdateIOS &&
        other.versionNumber == versionNumber &&
        other.versionNumberIOS == versionNumberIOS;
  }

  @override
  int get hashCode {
    return forceUpdate.hashCode ^
        forceUpdateIOS.hashCode ^
        versionNumber.hashCode ^
        versionNumberIOS.hashCode;
  }
}
