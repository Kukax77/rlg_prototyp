// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rlg/domain/entities/id.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';

class TomorrowQuestModel {
  final String id;
  final String title;
  final String body;
  final bool done;
  final dynamic serverTimeStamp;

  TomorrowQuestModel(
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

  factory TomorrowQuestModel.fromMap(Map<String, dynamic> map) {
    return TomorrowQuestModel(
      id: "",
      title: map['title'] as String,
      body: map['body'] as String,
      done: map['done'] as bool,
      serverTimeStamp: map['serverTimeStamp'] as dynamic,
    );
  }

  TomorrowQuestModel copyWith({
    String? id,
    String? title,
    String? body,
    bool? done,
    dynamic serverTimeStamp,
  }) {
    return TomorrowQuestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      done: done ?? this.done,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  factory TomorrowQuestModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return TomorrowQuestModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  TomorrowQuest toDomain() {
    return TomorrowQuest(
        id: UniqueId.fromUniqueString(id),
        title: title,
        body: body,
        done: done,
        serverTimeStamp: serverTimeStamp);
  }

  factory TomorrowQuestModel.fromDomain(TomorrowQuest tomorrowQuestItem) {
    return TomorrowQuestModel(
        id: tomorrowQuestItem.id.value,
        title: tomorrowQuestItem.title,
        body: tomorrowQuestItem.body,
        done: tomorrowQuestItem.done,
        serverTimeStamp: FieldValue.serverTimestamp());
  }
}
