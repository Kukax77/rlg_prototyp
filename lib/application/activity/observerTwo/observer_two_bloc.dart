import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/activity.dart';
import 'package:rlg/domain/repositories/activity_repository.dart';

part 'observer_two_event.dart';
part 'observer_two_state.dart';

class ObserverTwoBloc extends Bloc<ObserverTwoEvent, ObserverTwoState> {
  final ActivityRepository activityRepository;

    StreamSubscription<Either<QuestFailure, List<Activity>>>? _activityStreamSub;


  ObserverTwoBloc({required this.activityRepository}) : super(ObserverTwoInitial()) {
    on<ObserveAllActivitysEventTwo>((event, emit)async{
      emit(ActivityObserverLoadingTwo());
      await _activityStreamSub?.cancel();
      _activityStreamSub =
          activityRepository.watchAll().listen((failureOrActivitys) {
        add(ActivitysUpdatedEventTwo(failureOrActivitys: failureOrActivitys));
      });
    });

    on<ActivitysUpdatedEventTwo>((event, emit) {
      event.failureOrActivitys
          .fold((failures) => emit(ActivityObserverFailureTwo(failure: failures)),
              (activitys) {
        emit(ActivityObserverSuccessTwo(activitys: activitys));
      });
    });

     @override
    Future<void> close() async {
      await _activityStreamSub?.cancel();
      return super.close();
    }
  }
}
