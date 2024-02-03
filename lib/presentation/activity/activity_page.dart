import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/activity/controller/activity_controller_bloc.dart';
import 'package:rlg/application/activity/observerTwo/observer_two_bloc.dart';
import 'package:rlg/application/management/points/controller/points_manager_bloc.dart';
import 'package:rlg/application/management/points/observer/points_observer_bloc.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/injection.dart';
import 'package:rlg/presentation/activity/widgets/activity_body.dart';
import 'package:rlg/presentation/routes/router.gr.dart';

@RoutePage()
class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pointsObserverBloc = sl<PointsObserverBloc>()
      ..add(ObserveAllPointsEvent());
    final activityObserver = sl<ObserverTwoBloc>()
      ..add(ObserveAllActivitysEventTwo());

    String getFailureMessage(QuestFailure failure) {
      switch (failure.runtimeType) {
        case QuestInsufficientPermissions:
          return "You dont have the permissions to do that";
        case QuestUnexpectedFailure:
          return "Ups! Something went wrong";
        default:
          return "Ups! Something went wrong";
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<PointsObserverBloc>(
          create: (context) => pointsObserverBloc,
        ),
        BlocProvider<PointsManagerBloc>(
          create: (context) => sl<PointsManagerBloc>(),
        ),
        BlocProvider<ObserverTwoBloc>(
          create: (context) => activityObserver,
        ),
        BlocProvider<ActivityControllerBloc>(
          create: (context) => sl<ActivityControllerBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<PointsManagerBloc, PointsManagerState>(
              listener: (context, state) {
            if (state is PointsUpdateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(getFailureMessage(state.failure)),
                backgroundColor: Colors.redAccent,
              ));
            }
          }),
          BlocListener<ActivityControllerBloc, ActivityControllerState>(
              listener: (context, state) {
            if (state is ActivityControllerFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(getFailureMessage(state.activityFailure)),
                backgroundColor: Colors.redAccent,
              ));
            }
          }),
        ],
        child: Scaffold(
          body: const ActivityBody(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              if (index == 0) {
                AutoRouter.of(context).replace(const HomeRoute());
              }
            },
            unselectedItemColor: Colors.grey,
            currentIndex: 1,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  label: "Shop")
            ],
          ),
        ),
      ),
    );
  }
}
