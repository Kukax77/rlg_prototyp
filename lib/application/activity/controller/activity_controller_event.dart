part of 'activity_controller_bloc.dart';

@immutable
sealed class ActivityControllerEvent {}

class DeleteActivityEvent extends ActivityControllerEvent{
  final Activity activity;

  DeleteActivityEvent({required this.activity});
}

class CreateActivityEvent extends ActivityControllerEvent{

  final Activity activity;

  CreateActivityEvent({required this.activity});
}