// ignore_for_file: unused_element

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/domain/repositories/tomorrowquest_repository.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final TomorrowQuestRepository tomorrowQuestRepository;

  StreamSubscription<Either<TomorrowQuestFailure, List<TomorrowQuest>>>?
      _tomorrowquestStreamSub;

  ObserverBloc({required this.tomorrowQuestRepository})
      : super(ObserverInitial()) {
    on<ObserveAllEvent>((event, emit) async {
      emit(ObserverLoading());
      await _tomorrowquestStreamSub?.cancel();
      _tomorrowquestStreamSub = tomorrowQuestRepository.watchAll().listen(
          (failureOrTomorrowquests) => add(TomorrowquestUpdatedEvent(
              failureOrTomorrowquests: failureOrTomorrowquests)));
    });

    on<TomorrowquestUpdatedEvent>((event, emit) {
      print("test");
      event.failureOrTomorrowquests.fold(
          (failures) => emit(ObserverFailure(tomorrowQuestFailure: failures)),
          (tomorrowQuests) =>
              emit(ObserverSuccess(tomorrowQuests: tomorrowQuests)));
    });

    on<ObserverDontShowEvent>((event, emit) {
      emit(ObserverDontShow());
    });

    on<ObserverRefreshEvent>((event, emit) async {
      await _tomorrowquestStreamSub?.cancel();
      _tomorrowquestStreamSub = tomorrowQuestRepository.watchAll().listen(
          (failureOrTomorrowquests) => add(ObserverRefreshedEvsent(
              failureOrTomorrowquests: failureOrTomorrowquests)));
    });

    on<ObserverRefreshedEvsent>((event, emit) {
      event.failureOrTomorrowquests.fold(
          (l) => emit(ObserverFailure(tomorrowQuestFailure: l)),
          (r) => emit (ObserverRefresh(tomorrowQuests: r)));
              
    });

    @override
    Future<void> close() async {
      await _tomorrowquestStreamSub?.cancel();
      return super.close();
    }
  }
}
