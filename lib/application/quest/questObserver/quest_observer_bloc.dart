import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/quest.dart';
import 'package:rlg/domain/repositories/quest_repository.dart';

part 'quest_observer_event.dart';
part 'quest_observer_state.dart';

class QuestObserverBloc extends Bloc<QuestObserverEvent, QuestObserverState> {

  final QuestRepository questRepository;

  StreamSubscription<Either<QuestFailure, List<Quest>>>?
      _questStreamSub;

  QuestObserverBloc({required this.questRepository}) : super(QuestObserverInitial()) {

    on<ObserveAllQuestsEvent>((event, emit) async {
      print("ObserveAllEvent got called");
      emit(QuestObserverLoading());
      await _questStreamSub?.cancel();
      _questStreamSub = questRepository.watchAll().listen(
        (failureOrQuests) { add(QuestUpdatedEvent(
            failureOrQuests: failureOrQuests));});
    });

    on<QuestUpdatedEvent>((event, emit) {
      event.failureOrQuests.fold(
          (failures) => emit(QuestObserverFailure(questFailure: failures)),
          (quests) {
              emit(QuestObserverSuccess(quests: quests));});
    });

    @override
    Future<void> close() async {
      await _questStreamSub?.cancel();
      return super.close();
    }
  }
}