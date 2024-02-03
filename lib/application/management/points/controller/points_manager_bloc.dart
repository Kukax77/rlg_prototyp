import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/domain/entities/quest.dart';
import 'package:rlg/domain/repositories/points_repository.dart';
import 'package:rlg/domain/repositories/quest_repository.dart';

part 'points_manager_event.dart';
part 'points_manager_state.dart';

class PointsManagerBloc extends Bloc<PointsManagerEvent, PointsManagerState> {
  final PoinstRepository pointsRepository;
  final QuestRepository questRepository;

  PointsManagerBloc(
      {required this.pointsRepository, required this.questRepository})
      : super(PointsManagerInitial()) {
    on<GetQuestsToDeleteEvent>((event, emit) async {
      print("event got called");
      for (Quest quest in event.quests) {
        final failureOrSuccess = await questRepository.delete(quest);
        failureOrSuccess.fold((l) => emit(PointsUpdateFailure(failure: l)),
            (r) async {
          final failureOrSuccessTwo =
              await pointsRepository.updatePoints(event.menge);
          failureOrSuccessTwo.fold((l) => emit(PointsUpdateFailure(failure: l)),
              (r) => emit(PointsUpdateSuccess()));
        });
      }
    });

    on<PointsUpdatingEvent>(((event, emit) async{
      
      final failureOrSuccess = await pointsRepository.updatePoints(event.menge);

      failureOrSuccess.fold((l) => emit(PointsUpdateFailure(failure: l)), (r) => emit(PointsUpdateSuccess()));
    }));
  }
}
