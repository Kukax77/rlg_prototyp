part of 'points_manager_bloc.dart';

@immutable
sealed class PointsManagerState {}

final class PointsManagerInitial extends PointsManagerState {}

class PointsUpdateSuccess extends PointsManagerState {}

class PointsUpdateFailure extends PointsManagerState {
  final QuestFailure failure;

  PointsUpdateFailure({required this.failure});
}

class PointsUpdating extends PointsManagerState{}
