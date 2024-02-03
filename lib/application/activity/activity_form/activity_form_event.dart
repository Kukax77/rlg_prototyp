part of 'activity_form_bloc.dart';

@immutable
sealed class ActivityFormEvent {}

class InitializeActivityDetailPage extends ActivityFormEvent {
  final Activity? activity;

  InitializeActivityDetailPage({required this.activity});
}

class ActivitySavedPressedEvent extends ActivityFormEvent {
  final String? title;
  final String? body;

  ActivitySavedPressedEvent({required this.title, required this.body});
}
