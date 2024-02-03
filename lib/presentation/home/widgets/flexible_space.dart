import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/auth/auth_bloc/auth_bloc.dart';
import 'package:rlg/application/tomorrowquest/observer/observer_bloc.dart';
import 'package:rlg/presentation/core/points_text.dart';

class FlexibleSpace extends StatelessWidget {
  const FlexibleSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        background: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90, top: 15, left: 20),
              child: Image.asset("assets/quest.png"),
            ),
            const Spacer(),
            const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: PointsText(),
                )),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Transform.scale(
                    scale: 2,
                    child: IconButton(
                      icon: const Icon(Icons.menu_open),
                      onPressed: () {
                        BlocProvider.of<ObserverBloc>(context)
                            .add(ObserveAllEvent());
                      },
                    ),
                  )),
            )
          ],
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
        title: Row(
          children: [
            Text(
              "Qeusts",
              textScaler: const TextScaler.linear(2),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
              },
            ),
          ],
        ));
  }
}
