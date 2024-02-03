import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/quest.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/domain/repositories/quest_repository.dart';
import 'package:rlg/infrastructure/extentions/firebase_helpers.dart';
import 'package:rlg/infrastructure/models/quest_model.dart';
import 'package:rlg/infrastructure/models/tomorrowquest_model.dart';

class QuestRepositoryImpl implements QuestRepository {
  final FirebaseFirestore firestore;

  QuestRepositoryImpl({required this.firestore});

  @override
  Future<Either<TomorrowQuestFailure, Unit>> create(
      TomorrowQuest tomorrowQuest) async {
    try {
      final userDoc = await firestore.userDocument();

      final tomorrowQuestModel = TomorrowQuestModel.fromDomain(tomorrowQuest);

      await userDoc.questCollection
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
  Future<Either<QuestFailure, Unit>> delete(Quest quest) async {
    try {
      final userDoc = await firestore.userDocument();

      final questModel = QuestModel.fromDomain(quest);

      await userDoc.questCollection.doc(questModel.id).delete();
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
  Stream<Either<QuestFailure, List<Quest>>> watchAll() async* {
    final userDoc = await firestore.userDocument();
    yield* userDoc.questCollection
        .snapshots()
        .map((snapshot) =>
            //listen on tq's (right)
            right<QuestFailure, List<Quest>>(snapshot.docs
                .map((doc) => QuestModel.fromFirestore(doc).toDomain())
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

  @override
  Future<Either<QuestFailure, Unit>> update(Quest quest) async {
    print("quest watch all got called");
    try {
      final userDoc = await firestore.userDocument();

      final questModel = QuestModel.fromDomain(quest);

      await userDoc.questCollection
          .doc(questModel.id)
          .update(questModel.toMap());
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
  Future<Either<QuestFailure, List<Quest>>> getQuests() async {
    try {
      final userDoc = await firestore.userDocument();
      final snapShot = await userDoc.questCollection.get();
      final questData =
          snapShot.docs.map((e) => QuestModel.fromFirestore(e)).toList();

      return right(questData.map((e) => e.toDomain()).toList());
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
