part of 'activity_controller_bloc.dart';

@immutable
sealed class ActivityControllerState {}

final class ActivityControllerInitial extends ActivityControllerState {}

class ActivityControllerInProgress extends ActivityControllerState {}

class ActivityControllerSuccess extends ActivityControllerState {}

class ActivityControllerFailure extends ActivityControllerState {
  final QuestFailure activityFailure;

  ActivityControllerFailure({required this.activityFailure});
}