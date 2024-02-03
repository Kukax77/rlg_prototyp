import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/quest.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';

abstract class QuestRepository {
  Stream<Either<QuestFailure, List<Quest>>> watchAll();

  Future<Either<TomorrowQuestFailure, Unit>> create(TomorrowQuest tomorrowQuest);

  Future<Either<QuestFailure, Unit>> delete(Quest quest);

  Future<Either<QuestFailure, Unit>> update(Quest quest);

  Future<Either<QuestFailure, List<Quest>>> getQuests();
}
