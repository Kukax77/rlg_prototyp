part of 'activity_form_bloc.dart';


class ActivityFormState {

  final Activity activity;
  final bool showErrorMessages;
  final bool isSaving;
  final Option<Either<QuestFailure, Unit>> failureOrSuccessOption;

  ActivityFormState(
      {required this.activity,
      required this.showErrorMessages,
      required this.isSaving,
      required this.failureOrSuccessOption,});

  factory ActivityFormState.initial() => ActivityFormState(
      activity: Activity.empty(),
      showErrorMessages: false,
      isSaving: false,
      failureOrSuccessOption: none(),);

      

  ActivityFormState copyWith({
    Activity? activity,
    bool? showErrorMessages,
    bool? isSaving,
    Option<Either<QuestFailure, Unit>>? failureOrSuccessOption,
  }) {
    return ActivityFormState(
      activity: activity ?? this.activity,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      failureOrSuccessOption: failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}

