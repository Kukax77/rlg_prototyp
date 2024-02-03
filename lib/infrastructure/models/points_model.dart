import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rlg/domain/entities/id.dart';
import 'package:rlg/domain/entities/points.dart';

class PointsModel {
  final String id;
  final int points;

 PointsModel(
      {required this.points, required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id' : id,
      'points' : points
    };
  }

  factory PointsModel.fromMap(Map<String, dynamic> map) {
    return PointsModel(
      id: "",
      points: map['points'] as int 
    );
  }

  PointsModel copyWith({
    String? id,
    int? points,
  }) {
    return PointsModel(
      id: id ?? this.id,
      points: points ?? this.points,
    );
  }

  factory PointsModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return PointsModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Points toDomain() {
    return Points(
        id: UniqueId.fromUniqueString(id),
        points: points);
  }

  factory PointsModel.fromDomain(String id, int newPoints) {
    return PointsModel(
        id: id,
        points: newPoints);
  }
}
