part of 'points_observer_bloc.dart';

@immutable
sealed class PointsObserverState {}

final class PointsObserverInitial extends PointsObserverState {}

class PointsObserverUpdated extends PointsObserverState{

  final List<Points> points;
  
  PointsObserverUpdated({required this.points});

}

class PointsObserverFailure extends PointsObserverState{

  final QuestFailure failure;

  PointsObserverFailure({required this.failure});
}
