import '../enums/gender.dart';
import '../enums/status.dart';

class Params {
  final Gender gender;
  final Status status;
  Params({
    required this.gender,
    required this.status,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Params && other.gender == gender && other.status == status;
  }

  @override
  int get hashCode => gender.hashCode ^ status.hashCode;
}