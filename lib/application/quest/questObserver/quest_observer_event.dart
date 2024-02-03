part of 'quest_observer_bloc.dart';

@immutable
sealed class QuestObserverEvent {}

class ObserveAllQuestsEvent extends QuestObserverEvent {}

class QuestUpdatedEvent extends QuestObserverEvent {
  final Either<QuestFailure, List<Quest>> failureOrQuests;

  QuestUpdatedEvent({required this.failureOrQuests});
}
