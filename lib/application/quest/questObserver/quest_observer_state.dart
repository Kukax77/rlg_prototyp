part of 'quest_observer_bloc.dart';

@immutable
sealed class QuestObserverState {}

final class QuestObserverInitial extends QuestObserverState {}

class QuestObserverLoading extends QuestObserverState{}

class QuestObserverFailure extends QuestObserverState{

  final QuestFailure questFailure;

  QuestObserverFailure({required this.questFailure});
}

class QuestObserverSuccess extends QuestObserverState{

  final List<Quest> quests;

  QuestObserverSuccess({required this.quests});
}