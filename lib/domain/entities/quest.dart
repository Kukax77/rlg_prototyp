// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rlg/domain/entities/id.dart';

class Quest {
  final UniqueId id;
  final String title;
  final String body;
  final bool done;
  final dynamic serverTimeStamp;

  Quest(
      {required this.id,
      required this.title,
      required this.body,
      required this.done,
      required this.serverTimeStamp});

  factory Quest.empty(){

    return Quest(id: UniqueId(), title: "", body: "", done: false, serverTimeStamp: 0);
  }

  Quest copyWith({
    UniqueId? id,
    String? title,
    String? body,
    bool? done,
    dynamic serverTimeStamp,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      done: done ?? this.done,
      serverTimeStamp: serverTimeStamp?? this.serverTimeStamp,
    );
  }
}