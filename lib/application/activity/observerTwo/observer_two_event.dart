part of 'observer_two_bloc.dart';

@immutable
sealed class ObserverTwoEvent {}

class ObserveAllActivitysEventTwo extends ObserverTwoEvent{}

class ActivitysUpdatedEventTwo extends ObserverTwoEvent{

  final Either<QuestFailure, List<Activity>> failureOrActivitys;

  ActivitysUpdatedEventTwo({required this.failureOrActivitys});
}