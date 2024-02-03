// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:rlg/domain/entities/id.dart';

class TomorrowQuest {
  final UniqueId id;
  final String title;
  final String body;
  final bool done;
  final dynamic serverTimeStamp;

  TomorrowQuest(
      {required this.id,
      required this.title,
      required this.body,
      required this.done,
      required this.serverTimeStamp});

  factory TomorrowQuest.empty(){

    return TomorrowQuest(id: UniqueId(), title: "", body: "", done: false, serverTimeStamp: 0);
  }

  TomorrowQuest copyWith({
    UniqueId? id,
    String? title,
    String? body,
    bool? done,
    dynamic serverTimeStampk
  }) {
    return TomorrowQuest(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      done: done ?? this.done,
      serverTimeStamp: serverTimeStamp?? serverTimeStamp,
    );
  }
}
