import 'package:cloud_firestore/cloud_firestore.dart';

class Ad {
  final String id;
  final String? image;
  final String title;
  final String description;
  final DateTime createdAt;

  Ad({
    required this.id,
     this.image,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Ad copyWith({
    String? id,
    String? image,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return Ad(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Ad.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Ad(
      id: doc.id,
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['createdAt'].toDate(),
    );
  }

  factory Ad.empty() => Ad(
        id: '',
        title: '',
        description: '',
        createdAt: DateTime.now(),
      );
}
