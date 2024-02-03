part of 'quest_controller_bloc.dart';

@immutable
sealed class QuestControllerState {}

final class QuestControllerInitial extends QuestControllerState {}

class QuestControllerInProgress extends QuestControllerState {}

class QuestControllerSuccess extends QuestControllerState {}

class QuestControllerFailure extends QuestControllerState {
  final QuestFailure questFailure;

  QuestControllerFailure({required this.questFailure});
}