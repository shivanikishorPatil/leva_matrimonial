import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leva_matrimonial/enums/role.dart';

class Profile {
  final String id;

  final String phone;
  final String email;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Role role;


  Profile({
    required this.id,
    required this.phone,
    required this.email,
    required this.createdAt,
    required this.role,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'role': role.name,
    };
  }

  factory Profile.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Profile(
      id: doc.id,
      phone: map['phone'],
      email: map['email'],
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt']?.toDate(),
      role: Role.values.where((element) => element.name == map['role']).first,
    );
  }

  factory Profile.empty() => Profile(
        id: '',
        phone: '',
        createdAt: DateTime.now(),
        email: '',
        role: Role.user,
      );

  Profile copyWith({
    String? id,

    String? phone,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role,
    );
  }
}
