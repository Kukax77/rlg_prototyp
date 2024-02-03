
import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';

abstract class TomorrowQuestRepository{

  Stream<Either<TomorrowQuestFailure,List<TomorrowQuest>>> watchAll();

  Future<Either<TomorrowQuestFailure,Unit>> create(TomorrowQuest tomorrowQuest);

  Future<Either<TomorrowQuestFailure,Unit>> update(TomorrowQuest tomorrowQuest);

  Future<Either<TomorrowQuestFailure,Unit>> delete(TomorrowQuest tomorrowQuest);
}