import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rlg/domain/entities/activity.dart';
import 'package:rlg/domain/entities/id.dart';

class ActivityModel {
  final String id;
  final String title;
  final String body;
  final int price;

  ActivityModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.price});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'price': price,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: "",
      title: map['title'] as String,
      body: map['body'] as String,
      price: map['price'] as int,
    );
  }

  ActivityModel copyWith({
    String? id,
    String? title,
    String? body,
    int? price,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      price: price ?? this.price,
    );
  }

  factory ActivityModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ActivityModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Activity toDomain() {
    return Activity(
        id: UniqueId.fromUniqueString(id),
        title: title,
        body: body,
        price: price);
  }

  factory ActivityModel.fromDomain(Activity activityItem) {
    return ActivityModel(
        id: activityItem.id.value,
        title: activityItem.title,
        body: activityItem.body,
        price: activityItem.price);
  }
}