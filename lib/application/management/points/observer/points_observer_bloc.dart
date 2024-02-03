import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/points.dart';
import 'package:rlg/domain/repositories/points_repository.dart';

part 'points_observer_event.dart';
part 'points_observer_state.dart';

class PointsObserverBloc
    extends Bloc<PointsObserverEvent, PointsObserverState> {
  final PoinstRepository pointsRepository;

  StreamSubscription<Either<QuestFailure, List<Points>>>? _pointsStreamSub;
  PointsObserverBloc({required this.pointsRepository})
      : super(PointsObserverInitial()) {
    on<ObserveAllPointsEvent>((event, emit) async {
      await _pointsStreamSub?.cancel();
      _pointsStreamSub = pointsRepository.watchAll().listen((failureOrPoints) =>
          add(GotPointsOrFailureEvent(failureOrPoints: failureOrPoints)));
    });

    on<GotPointsOrFailureEvent>((event, emit) {
      event.failureOrPoints.fold(
          (failures) => emit(PointsObserverFailure(failure: failures)),
          (points) => emit(PointsObserverUpdated(points: points)));
    });

    @override
    Future<void> close() async {
      await _pointsStreamSub?.cancel();
      return super.close();
    }
  }
}
