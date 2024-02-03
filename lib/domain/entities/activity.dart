import 'package:rlg/domain/entities/id.dart';

class Activity{

  final UniqueId id;
  final String title;
  final String body;
  final int price;

  Activity({required this.id, required this.title, required this.body, required this.price});

  factory Activity.empty(){

    return Activity(id: UniqueId(), title: "", body: "", price: 0);
  }

  Activity copyWith({
    UniqueId? id,
    String? title,
    String? body,
    int? price,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      price: price ?? this.price
    );
  }

}