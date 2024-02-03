part of 'controller_bloc.dart';

@immutable
sealed class ControllerState {}

final class ControllerInitial extends ControllerState {}

class ControllerInProgress extends ControllerState {}

class ControllerSuccess extends ControllerState {}

class ControllerFailure extends ControllerState {
  final TomorrowQuestFailure tomorrowQuestFailure;

  ControllerFailure({required this.tomorrowQuestFailure});
}


