
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/activity.dart';
import 'package:rlg/domain/repositories/activity_repository.dart';
import 'package:rlg/infrastructure/extentions/firebase_helpers.dart';
import 'package:rlg/infrastructure/models/activity_model.dart';

class ActivityRepositoryIMPL implements ActivityRepository{

  final FirebaseFirestore firestore;

  ActivityRepositoryIMPL({required this.firestore});
  @override
  Future<Either<QuestFailure, Unit>> create(Activity activity) async{
    try {
      final userDoc = await firestore.userDocument();

      final activityModel = ActivityModel.fromDomain(activity);

      await userDoc.activityCollection.doc(activityModel.id).set(activityModel.toMap());
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

  @override
   Future<Either<QuestFailure, Unit>> delete(
      Activity activity) async {
    try {
      final userDoc = await firestore.userDocument();

      final activityModel = ActivityModel.fromDomain(activity);

      await userDoc.activityCollection.doc(activityModel.id).delete();
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
  
  @override
  Stream<Either<QuestFailure, List<Activity>>> watchAll() async*{
   final userDoc = await firestore.userDocument();
    yield* userDoc.activityCollection
        .snapshots()
        .map((snapshot) =>
            //listen on tq's (right)
            right<QuestFailure, List<Activity>>(snapshot.docs
                .map((doc) => ActivityModel.fromFirestore(doc).toDomain())
                .toList()))
        //Erorr handling(left)
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION-DENIED")) {
          return left(QuestInsufficientPermissions());
        } else {
          return left(QuestUnexpectedFailure());
        }
      } else {
        return left(QuestUnexpectedFailure());
      }
    });
  }

}