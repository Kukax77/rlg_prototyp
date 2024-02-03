part of 'observer_bloc.dart';

@immutable
sealed class ObserverState {}

final class ObserverInitial extends ObserverState {}

class ObserverLoading extends ObserverState{}

class ObserverFailure extends ObserverState{

  final TomorrowQuestFailure tomorrowQuestFailure;

  ObserverFailure({required this.tomorrowQuestFailure});
}

class ObserverSuccess extends ObserverState{

  final List<TomorrowQuest> tomorrowQuests;

  ObserverSuccess({required this.tomorrowQuests});
}

class ObserverDontShow extends ObserverState{}

class ObserverRefresh extends ObserverState{

  final List<TomorrowQuest> tomorrowQuests;

  ObserverRefresh({required this.tomorrowQuests});
}

