part of 'tomorrowquest_form_bloc_bloc.dart';

@immutable
sealed class TomorrowquestFormBlocEvent {}

class InitializeTomorowquestDetailPage extends TomorrowquestFormBlocEvent{

  final TomorrowQuest? tomorrowQuest;
  
  InitializeTomorowquestDetailPage({required this.tomorrowQuest});
}

class TQSavedPressedEvent extends TomorrowquestFormBlocEvent{
  final String? title;
  final String? body;

  TQSavedPressedEvent({required this.title, required this.body});
}
