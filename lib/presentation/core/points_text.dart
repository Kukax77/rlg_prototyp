import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/management/points/observer/points_observer_bloc.dart';
import 'package:rlg/core/failures/quest_failures.dart';

class PointsText extends StatelessWidget {
  const PointsText({super.key});

  @override
  Widget build(BuildContext context) {
    String mapFailure(QuestFailure failure) {
      if (failure is QuestInsufficientPermissions) {
        return "conection lost... please log back in!";
      } else {
        return "Ups! something went wrong. Please try angain!";
      }
    }

    return BlocBuilder<PointsObserverBloc, PointsObserverState>(
        builder: (context, state) {
      if (state is PointsObserverFailure) {
        return Center(
          child: Text(
            mapFailure(state.failure),
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.redAccent),
          ),
        );
      }
      if (state is PointsObserverUpdated) {
        return Text(
          "Points: ${state.points[0].points}",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
        );
      } else {
        return const Placeholder();
      }
    });
  }
}
