// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tomorrowquest_form_bloc_bloc.dart';

class TomorrowquestFormState {
  final TomorrowQuest tomorrowQuest;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<TomorrowQuestFailure, Unit>> failureOrSuccessOption;

  TomorrowquestFormState(
      {required this.tomorrowQuest,
      required this.showErrorMessages,
      required this.isEditing,
      required this.isSaving,
      required this.failureOrSuccessOption,});

  factory TomorrowquestFormState.initial() => TomorrowquestFormState(
      tomorrowQuest: TomorrowQuest.empty(),
      showErrorMessages: false,
      isEditing: false,
      isSaving: false,
      failureOrSuccessOption: none(),);

      

  TomorrowquestFormState copyWith({
    TomorrowQuest? tomorrowQuest,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<TomorrowQuestFailure, Unit>>? failureOrSuccessOption,
  }) {
    return TomorrowquestFormState(
      tomorrowQuest: tomorrowQuest ?? this.tomorrowQuest,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption: failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}
