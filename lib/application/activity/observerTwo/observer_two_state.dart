part of 'observer_two_bloc.dart';

@immutable
sealed class ObserverTwoState {}

final class ObserverTwoInitial extends ObserverTwoState {}

class ActivityObserverLoadingTwo extends ObserverTwoState{}

class ActivityObserverFailureTwo extends ObserverTwoState{

  final QuestFailure failure;

  ActivityObserverFailureTwo({required this.failure});
}

class ActivityObserverSuccessTwo extends ObserverTwoState{

  final List<Activity> activitys;

  ActivityObserverSuccessTwo({required this.activitys});}