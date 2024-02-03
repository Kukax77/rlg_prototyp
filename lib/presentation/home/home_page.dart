import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/auth/auth_bloc/auth_bloc.dart';
import 'package:rlg/application/management/points/controller/points_manager_bloc.dart';
import 'package:rlg/application/management/points/observer/points_observer_bloc.dart';
import 'package:rlg/application/quest/questController/quest_controller_bloc.dart';
import 'package:rlg/application/quest/questObserver/quest_observer_bloc.dart';
import 'package:rlg/application/tomorrowquest/controller/controller_bloc.dart';
import 'package:rlg/application/tomorrowquest/observer/observer_bloc.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/injection.dart';
import 'package:rlg/presentation/home/widgets/home_body.dart';
import 'package:rlg/presentation/routes/router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //final themeData = Theme.of(context);
    final observerBloc = sl<ObserverBloc>();
    final questObserverBloc = sl<QuestObserverBloc>()
      ..add(ObserveAllQuestsEvent());
    final pointsObserverBloc = sl<PointsObserverBloc>()
      ..add(ObserveAllPointsEvent());

    String getFailureMessage(TomorrowQuestFailure failure) {
      switch (failure.runtimeType) {
        case InsufficientPermissions:
          return "You dont have the permissions to do that";
        case UnexpectedFailure:
          return "Ups! Something went wrong";
        default:
          return "Ups! Something went wrong";
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverBloc>(
          create: (context) => observerBloc,
        ),
        BlocProvider<ControllerBloc>(create: (context) => sl<ControllerBloc>()),
        BlocProvider<QuestObserverBloc>(
          create: (context) => questObserverBloc,
        ),
        BlocProvider<QuestControllerBloc>(
            create: (context) => sl<QuestControllerBloc>()),
        BlocProvider<PointsObserverBloc>(
          create: (context) => pointsObserverBloc,
        ),
        BlocProvider<PointsManagerBloc>(
            create: (context) => sl<PointsManagerBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthStateUnAuthenticated) {
              AutoRouter.of(context).push(const SignUpRoute());
            }
          }),
          BlocListener<ControllerBloc, ControllerState>(
              listener: (context, state) {
            if (state is ControllerFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(getFailureMessage(state.tomorrowQuestFailure)),
                backgroundColor: Colors.redAccent,
              ));
            }
          }),
        ],
        child: Scaffold(
          body: const HomeBody(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                AutoRouter.of(context).replace(const ActivityRoute());
              }
            },
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
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
