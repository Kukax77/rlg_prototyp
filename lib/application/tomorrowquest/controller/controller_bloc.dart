import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/domain/repositories/quest_repository.dart';
import 'package:rlg/domain/repositories/tomorrowquest_repository.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  final TomorrowQuestRepository tomorrowQuestRepository;
  final QuestRepository questRepository;

  ControllerBloc(
      {required this.tomorrowQuestRepository, required this.questRepository})
      : super(ControllerInitial()) {
    on<DeleteTomorrowquestEvent>((event, emit) async {
      emit(ControllerInProgress());
      final failureOrSuccess =
          await tomorrowQuestRepository.delete(event.tomorrowQuest);
      failureOrSuccess.fold(
          (l) => emit(ControllerFailure(tomorrowQuestFailure: l)),
          (r) => emit(ControllerSuccess()));
    });

    on<UpdateTomorrowquestEvent>((event, emit) async {
      emit(ControllerInProgress());
      final failureOrSuccess = await tomorrowQuestRepository
          .update(event.tomorrowQuest.copyWith(done: event.done));
      failureOrSuccess.fold(
          (l) => emit(ControllerFailure(tomorrowQuestFailure: l)),
          (r) => emit(ControllerSuccess()));
    });

    on<ConvertTomorrowToQuestEvent>((event, emit) async {
      emit(ControllerInProgress());
      final failureOrSuccessConvert =
          await questRepository.create(event.tomorrowQuest);
      failureOrSuccessConvert.fold(
          (failure) => emit(ControllerFailure(tomorrowQuestFailure: failure)),
          (succsess) => add(
              TomorrowquestConvertedEvent(tomorrowQuest: event.tomorrowQuest)));
    });

    on<TomorrowquestConvertedEvent>(
      (event, emit) async {
        final fauilureOrSuccess =
            await tomorrowQuestRepository.delete(event.tomorrowQuest);
        fauilureOrSuccess.fold(
            (failure) => emit(ControllerFailure(tomorrowQuestFailure: failure)),
            (success) => emit(ControllerSuccess()));
      },
    );
  }
}
