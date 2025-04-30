import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStatusEntity {
  final String title;
  final bool done;
  final Timestamp createdDate;

  OrderStatusEntity({
    required this.title, 
    required this.done, 
    required this.createdDate
  });

  factory OrderStatusEntity.fromMap(Map<String, dynamic> map) {
    return OrderStatusEntity(
      title: map['title'] ?? '',
      done: map['done'] ?? false,
      createdDate: map['createdDate'] ?? Timestamp.now(),
    );
  }
}