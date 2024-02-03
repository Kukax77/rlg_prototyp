import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/activity.dart';

abstract class ActivityRepository{

  Future<Either<QuestFailure,Unit>>delete(Activity activity);

  Future<Either<QuestFailure,Unit>>create(Activity activity);

 Stream<Either<QuestFailure,List<Activity>>>watchAll();

}