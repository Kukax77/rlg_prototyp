
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/points.dart';
import 'package:rlg/domain/repositories/points_repository.dart';
import 'package:rlg/infrastructure/extentions/firebase_helpers.dart';
import 'package:rlg/infrastructure/models/points_model.dart';

class PoinstRepositoryImpl implements PoinstRepository{

  final FirebaseFirestore firestore;

  PoinstRepositoryImpl({required this.firestore});
  
  @override
  Stream<Either<QuestFailure, List<Points>>> watchAll() async* {
    final userDoc = await firestore.userDocument();
    yield* userDoc.pointsCollection
        .snapshots()
        .map((snapshot) =>
            //listen on tq's (right)
            right<QuestFailure, List<Points>>(snapshot.docs
                .map((doc) => PointsModel.fromFirestore(doc).toDomain()).toList()))
        //Erorr handling(left)
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION-DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }
  
  @override
  Future<Either<QuestFailure, Unit>> updatePoints(int menge) async {
    try {
      final userDoc = await firestore.userDocument();
      final snapShot = await userDoc.pointsCollection.where("points").get();
      final pointData = snapShot.docs.map((e) => PointsModel.fromFirestore(e)).single;
      print(pointData.points);

      final pointModel = PointsModel.fromDomain(pointData.id, pointData.points+menge);

       await userDoc.pointsCollection
          .doc(pointModel.id)
          .update(pointModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSIO_DENIED")) {
        return left(QuestInsufficientPermissions());
      } else if (e.code.contains("NOT_FOUND")) {
        return left(QuestDataFailure());
      } else {
        return left(QuestUnexpectedFailure());
      }
    }
  }
}