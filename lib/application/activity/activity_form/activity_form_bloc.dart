import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/activity.dart';
import 'package:rlg/domain/repositories/activity_repository.dart';

part 'activity_form_event.dart';
part 'activity_form_state.dart';

class ActivityFormBloc extends Bloc<ActivityFormEvent, ActivityFormState> {
  final ActivityRepository activityRepository;

  ActivityFormBloc({required this.activityRepository})
      : super(ActivityFormState.initial()) {
    on<InitializeActivityDetailPage>((event, emit) {
      if (event.activity != null) {
        emit(state.copyWith(activity: event.activity));
      } else {
        emit(state);
      }
    });

    on<ActivitySavedPressedEvent>(
      (event, emit) async {
        emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

        Either<QuestFailure, Unit>? failureOrSuccess;

        final Activity editedActivity =
            state.activity.copyWith(title: event.title, body: event.body);

        failureOrSuccess = await activityRepository.create(editedActivity);

        emit(state.copyWith(
            failureOrSuccessOption: optionOf(failureOrSuccess),
            isSaving: false,
            showErrorMessages: true));
      },
    );
  }
}
