import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/domain/repositories/tomorrowquest_repository.dart';
import 'package:rlg/infrastructure/extentions/firebase_helpers.dart';
import 'package:rlg/infrastructure/models/tomorrowquest_model.dart';

class TomorrowQuestRepositoryImpl implements TomorrowQuestRepository {
  final FirebaseFirestore firestore;

  TomorrowQuestRepositoryImpl({required this.firestore});

  @override
  Future<Either<TomorrowQuestFailure, Unit>> create(
      TomorrowQuest tomorrowQuest) async {
    try {
      final userDoc = await firestore.userDocument();

      final tomorrowQuestModel = TomorrowQuestModel.fromDomain(tomorrowQuest);

      await userDoc.tomorrowQuestCollection
          .doc(tomorrowQuestModel.id)
          .set(tomorrowQuestModel.toMap());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSIO_DENIED")) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TomorrowQuestFailure, Unit>> update(
      TomorrowQuest tomorrowQuest) async {
    try {
      final userDoc = await firestore.userDocument();

      final tomorrowQuestModel = TomorrowQuestModel.fromDomain(tomorrowQuest);

      await userDoc.tomorrowQuestCollection
          .doc(tomorrowQuestModel.id)
          .update(tomorrowQuestModel.toMap());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSIO_DENIED")) {
        return left(InsufficientPermissions());
      } else if (e.code.contains("NOT_FOUND")) {
        return left(DataFailure());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TomorrowQuestFailure, Unit>> delete(
      TomorrowQuest tomorrowQuest) async {
    try {
      final userDoc = await firestore.userDocument();

      final tomorrowQuestModel = TomorrowQuestModel.fromDomain(tomorrowQuest);

      await userDoc.tomorrowQuestCollection.doc(tomorrowQuestModel.id).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains("PERMISSIO_DENIED")) {
        return left(InsufficientPermissions());
      } else if (e.code.contains("NOT_FOUND")) {
        return left(DataFailure());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Stream<Either<TomorrowQuestFailure, List<TomorrowQuest>>> watchAll() async* {
    final userDoc = await firestore.userDocument();
    yield* userDoc.tomorrowQuestCollection
        .snapshots()
        .map((snapshot) =>
            //listen on tq's (right)
            right<TomorrowQuestFailure, List<TomorrowQuest>>(snapshot.docs
                .map((doc) => TomorrowQuestModel.fromFirestore(doc).toDomain())
                .toList()))
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
}
