

import 'package:dartz/dartz.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/points.dart';

abstract class PoinstRepository{

  Future<Either<QuestFailure, Unit>> updatePoints(int menge);
    
  Stream<Either<QuestFailure, List<Points>>> watchAll();

}