part of 'controller_bloc.dart';

@immutable
sealed class ControllerEvent {}

class DeleteTomorrowquestEvent extends ControllerEvent{
  final TomorrowQuest tomorrowQuest;

  DeleteTomorrowquestEvent({required this.tomorrowQuest});
}

class UpdateTomorrowquestEvent extends ControllerEvent{
  final TomorrowQuest tomorrowQuest;
  final bool done;

 UpdateTomorrowquestEvent({required this.tomorrowQuest, required this.done});
}

class ConvertTomorrowToQuestEvent extends ControllerEvent{

  final TomorrowQuest tomorrowQuest;

  ConvertTomorrowToQuestEvent({required this. tomorrowQuest});
}

class TomorrowquestConvertedEvent extends ControllerEvent{

  final TomorrowQuest tomorrowQuest;

  TomorrowquestConvertedEvent({required this.tomorrowQuest});
}

