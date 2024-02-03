import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/activity.dart';
import 'package:rlg/domain/repositories/activity_repository.dart';

part 'activity_controller_event.dart';
part 'activity_controller_state.dart';

class ActivityControllerBloc extends Bloc<ActivityControllerEvent, ActivityControllerState> {

  final ActivityRepository activityRepository;

  ActivityControllerBloc({required this.activityRepository}) : super(ActivityControllerInitial()) {
    on<DeleteActivityEvent>((event, emit) async {
      emit(ActivityControllerInProgress());
      final failureOrSuccess =
          await activityRepository.delete(event.activity);
      failureOrSuccess.fold(
          (l) => emit(ActivityControllerFailure(activityFailure: l)),
          (r) => emit(ActivityControllerSuccess()));
    });

    on<CreateActivityEvent>(((event, emit) async{
      
      emit(ActivityControllerInProgress());
      final failureOrSuccess =
      await activityRepository.create(event.activity);
      failureOrSuccess.fold(
          (l) => emit(ActivityControllerFailure(activityFailure: l)),
          (r) => emit(ActivityControllerSuccess()));
    }));
  }
}
