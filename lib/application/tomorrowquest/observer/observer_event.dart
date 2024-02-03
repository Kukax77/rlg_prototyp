part of 'observer_bloc.dart';

@immutable
sealed class ObserverEvent {}

class ObserveAllEvent extends ObserverEvent {}

class TomorrowquestUpdatedEvent extends ObserverEvent {
  final Either<TomorrowQuestFailure, List<TomorrowQuest>>
      failureOrTomorrowquests;

  TomorrowquestUpdatedEvent({required this.failureOrTomorrowquests});
}

class ObserverDontShowEvent extends ObserverEvent {}

class ObserverRefreshEvent extends ObserverEvent {}

class ObserverRefreshedEvsent extends ObserverEvent {
  final Either<TomorrowQuestFailure, List<TomorrowQuest>>
      failureOrTomorrowquests;

  ObserverRefreshedEvsent({required this.failureOrTomorrowquests});
}
