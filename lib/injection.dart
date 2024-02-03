import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rlg/application/activity/activity_form/activity_form_bloc.dart';
import 'package:rlg/application/activity/controller/activity_controller_bloc.dart';
import 'package:rlg/application/activity/observerTwo/observer_two_bloc.dart';
import 'package:rlg/application/auth/auth_bloc/auth_bloc.dart';
import 'package:rlg/application/auth/signupform/sign_up_form_bloc.dart';
import 'package:rlg/application/management/points/controller/points_manager_bloc.dart';
import 'package:rlg/application/management/points/observer/points_observer_bloc.dart';
import 'package:rlg/application/quest/questController/quest_controller_bloc.dart';
import 'package:rlg/application/quest/questObserver/quest_observer_bloc.dart';
import 'package:rlg/application/tomorrowquest/controller/controller_bloc.dart';
import 'package:rlg/application/tomorrowquest/observer/observer_bloc.dart';
import 'package:rlg/application/tomorrowquest/tomorrowquestForm/tomorrowquest_form_bloc_bloc.dart';
import 'package:rlg/domain/repositories/activity_repository.dart';
import 'package:rlg/domain/repositories/auth_repository.dart';
import 'package:rlg/domain/repositories/points_repository.dart';
import 'package:rlg/domain/repositories/quest_repository.dart';
import 'package:rlg/domain/repositories/tomorrowquest_repository.dart';
import 'package:rlg/infrastructure/repositories/activity_repository_impl.dart';
import 'package:rlg/infrastructure/repositories/auth_repository_impl.dart';
import 'package:rlg/infrastructure/repositories/points_repository_impl.dart';
import 'package:rlg/infrastructure/repositories/quest_repository_impl.dart';
import 'package:rlg/infrastructure/repositories/tomorrowquest_repository_impl.dart';

final sl = GetIt.I; //sl == service locator

Future<void> init() async {
   //extern
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);

   //auth
  //state management
  sl.registerFactory(() => SignUpFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  sl.registerFactory(
      () => TomorrowquestFormBlocBloc(tomorrowQuestRepository: sl()));

  //repos
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

   //tq
  // state management
  sl.registerFactory(() => ObserverBloc(tomorrowQuestRepository: sl()));
  sl.registerFactory(() =>
      ControllerBloc(tomorrowQuestRepository: sl(), questRepository: sl()));
  //repos
  sl.registerLazySingleton<TomorrowQuestRepository>(
      () => TomorrowQuestRepositoryImpl(firestore: sl()));

   //quest
  //state management
  sl.registerFactory(() => QuestObserverBloc(questRepository: sl()));
  sl.registerFactory(() => QuestControllerBloc(questRepository: sl()));
  //repos
  sl.registerLazySingleton<QuestRepository>(
      () => QuestRepositoryImpl(firestore: sl()));

   //points
  //state management
  sl.registerFactory(
      () => PointsManagerBloc(pointsRepository: sl(), questRepository: sl()));
  sl.registerFactory(() => PointsObserverBloc(pointsRepository: sl()));

  //repos
  sl.registerLazySingleton<PoinstRepository>(
      () => PoinstRepositoryImpl(firestore: sl()));

   //activitys
  //repos
  sl.registerLazySingleton<ActivityRepository>(
      () => ActivityRepositoryIMPL(firestore: sl()));

  //state management
  sl.registerFactory(() => ObserverTwoBloc(activityRepository: sl()));
  sl.registerFactory(() => ActivityFormBloc(activityRepository: sl()));
  sl.registerFactory(() => ActivityControllerBloc(activityRepository: sl()));
}
