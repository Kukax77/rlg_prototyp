import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/domain/repositories/tomorrowquest_repository.dart';

part 'tomorrowquest_form_bloc_event.dart';
part 'tomorrowquest_form_bloc_state.dart';

class TomorrowquestFormBlocBloc
    extends Bloc<TomorrowquestFormBlocEvent, TomorrowquestFormState> {
  final TomorrowQuestRepository tomorrowQuestRepository;
  TomorrowquestFormBlocBloc({required this.tomorrowQuestRepository})
      : super(TomorrowquestFormState.initial()) {
    on<InitializeTomorowquestDetailPage>((event, emit) {
      if (event.tomorrowQuest != null) {
        emit(state.copyWith(
            isEditing: true, tomorrowQuest: event.tomorrowQuest));
      } else {
        emit(state);
      }
    });

    on<TQSavedPressedEvent>(
      (event, emit) async {
        emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

        Either<TomorrowQuestFailure, Unit>? failureOrSuccess;

        if (event.title != null && event.body != null) {
          final TomorrowQuest editedTomorrowquest = state.tomorrowQuest
              .copyWith(title: event.title, body: event.body);

          if (state.isEditing) {
            failureOrSuccess =
                await tomorrowQuestRepository.update(editedTomorrowquest);
          } else {
            failureOrSuccess =
                await tomorrowQuestRepository.create(editedTomorrowquest);
          }
        }

        emit(state.copyWith(
            failureOrSuccessOption: optionOf(failureOrSuccess),
            isSaving: false,
            showErrorMessages: true));
      },
    );
  }
}
