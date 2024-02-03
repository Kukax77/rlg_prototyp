import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/tomorrowquest/controller/controller_bloc.dart';
import 'package:rlg/application/tomorrowquest/observer/observer_bloc.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/presentation/core/custom_add_button.dart';
import 'package:rlg/presentation/home/widgets/quests/quest_body.dart';
import 'package:rlg/presentation/home/widgets/tomorrowquest_card.dart';
import 'package:rlg/presentation/routes/router.gr.dart';
import 'package:timer_builder/timer_builder.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    String mapFailure(TomorrowQuestFailure failure) {
      if (failure is QuestInsufficientPermissions) {
        return "conection lost... please log back in!";
      } else {
        return "Ups! something went wrong. Please try angain!";
      }
    }

    return TimerBuilder.periodic(const Duration(minutes: 1), builder: (context) {

      BlocProvider.of<ObserverBloc>(context).add(ObserverRefreshEvent());


      return BlocBuilder<ObserverBloc, ObserverState>(
        builder: (context, state) {
          if (state is ObserverRefresh) {
               for(TomorrowQuest quest in state.tomorrowQuests) {
              final DateTime date = quest.serverTimeStamp.toDate();
              final DateTime currenTime = DateTime.now();
              
              if (date.day != currenTime.day) {
                BlocProvider.of<ControllerBloc>(context)
                    .add(ConvertTomorrowToQuestEvent(tomorrowQuest: quest));
              }
            }
            return const QuestBody();
          }
          if (state is ObserverInitial || state is ObserverDontShow) {
            return const QuestBody();
          } else if (state is ObserverLoading) {
            return const Stack(
              children: [QuestBody(), CircularProgressIndicator()],
            );
          } else if (state is ObserverFailure) {
            return Center(
              child: Text(
                mapFailure(state.tomorrowQuestFailure),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Colors.redAccent),
              ),
            );
          } else if (state is ObserverSuccess) {
            final List<TomorrowQuest> tomorrowQuests = state.tomorrowQuests;
            return Stack(
              children: [
                const QuestBody(),
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Center(
                      child: Material(
                    elevation: 26,
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Tomorrow Quests",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Transform.scale(
                                    scale: 2,
                                    child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<ObserverBloc>(context)
                                              .add(ObserverDontShowEvent());
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              itemBuilder: (context, index) {
                                final tomorrowQuest = tomorrowQuests[index];
                                return TomorrowQuestCard(
                                  tomorrowQuest: tomorrowQuest,
                                );
                              },
                              itemCount: tomorrowQuests.length,
                              shrinkWrap: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (tomorrowQuests.length < 5) ...[
                              CustomAddButton(onTab: () {
                                AutoRouter.of(context).push(
                                    TomorrowQuestDetail(tomorrowQuest: null));
                              })
                            ]
                          ],
                        ),
                      ),
                    ),
                  )),
                ),
              ],
            );
          }
          return const Placeholder();
        },
      );
    });
  }
}
