part of 'points_observer_bloc.dart';

@immutable
sealed class PointsObserverEvent {}

class ObserveAllPointsEvent extends PointsObserverEvent{}

class GotPointsOrFailureEvent extends PointsObserverEvent{

  final Either<QuestFailure, List<Points>> failureOrPoints;

  GotPointsOrFailureEvent({required this.failureOrPoints});
}
