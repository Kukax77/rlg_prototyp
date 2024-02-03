import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/quest.dart';
import 'package:rlg/domain/repositories/quest_repository.dart';

part 'quest_controller_event.dart';
part 'quest_controller_state.dart';

class QuestControllerBloc extends Bloc<QuestControllerEvent, QuestControllerState> {
  final QuestRepository questRepository;
  QuestControllerBloc({required this.questRepository}) : super(QuestControllerInitial()) {

    on<DeleteQuestEvent>((event, emit) async {
      emit(QuestControllerInProgress());
      final failureOrSuccess =
          await questRepository.delete(event.quest);
      failureOrSuccess.fold(
          (l) => emit(QuestControllerFailure(questFailure: l)),
          (r) => emit(QuestControllerSuccess()));
    });

    on<UpdateQuestEvent>((event, emit) async {
      emit(QuestControllerInProgress());
      final failureOrSuccess = await questRepository
          .update(event.quest.copyWith(done: event.done));
      failureOrSuccess.fold(
          (l) => emit(QuestControllerFailure(questFailure: l)),
          (r) => emit(QuestControllerSuccess()));
    });
  }
}
