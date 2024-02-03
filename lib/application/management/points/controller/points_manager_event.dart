part of 'points_manager_bloc.dart';

@immutable
sealed class PointsManagerEvent {}

class GetQuestsToDeleteEvent extends PointsManagerEvent{
  final int menge;
    final List<Quest> quests;

  GetQuestsToDeleteEvent({required this.menge, required this.quests});
}

class PointsUpdatingEvent extends PointsManagerEvent{

  final int menge;

  PointsUpdatingEvent({required this.menge });
}
