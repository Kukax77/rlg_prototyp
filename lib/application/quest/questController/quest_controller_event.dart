part of 'quest_controller_bloc.dart';

@immutable
sealed class QuestControllerEvent {}

class DeleteQuestEvent extends QuestControllerEvent{
  final Quest quest;

  DeleteQuestEvent({required this.quest});
}

class UpdateQuestEvent extends QuestControllerEvent{
  final Quest quest;
  final bool done;

 UpdateQuestEvent({required this.quest, required this.done});
}
