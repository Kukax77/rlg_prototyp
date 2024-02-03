// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rlg/domain/entities/id.dart';
import 'package:rlg/domain/entities/quest.dart';

class QuestModel {
  final String id;
  final String title;
  final String body;
  final bool done;
  final dynamic serverTimeStamp;

  QuestModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.done,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'done': done,
      'serverTimeStamp': serverTimeStamp,
    };
  }

  factory QuestModel.fromMap(Map<String, dynamic> map) {
    return QuestModel(
      id: "",
      title: map['title'] as String,
      body: map['body'] as String,
      done: map['done'] as bool,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  QuestModel copyWith({
    String? id,
    String? title,
    String? body,
    bool? done,
    dynamic serverTimeStamp,
  }) {
    return QuestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      done: done ?? this.done,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  factory QuestModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return QuestModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Quest toDomain() {
    return Quest(
        id: UniqueId.fromUniqueString(id),
        title: title,
        body: body,
        done: done,
        serverTimeStamp: serverTimeStamp);
  }

  factory QuestModel.fromDomain(Quest questItem) {
    return QuestModel(
        id: questItem.id.value,
        title: questItem.title,
        body: questItem.body,
        done: questItem.done,
        serverTimeStamp: FieldValue.serverTimestamp());
  }
}
