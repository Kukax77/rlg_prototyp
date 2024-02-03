import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/quest/questObserver/quest_observer_bloc.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/presentation/home/widgets/flexible_space.dart';
import 'package:rlg/presentation/home/widgets/quests/quest_item.dart';
import 'package:rlg/presentation/home/widgets/quests/quest_state_manage.dart';

class QuestBody extends StatelessWidget {
  const QuestBody({super.key});

  String mapFailure(QuestFailure failure) {
    if (failure is QuestInsufficientPermissions) {
      return "conection lost... please log back in!";
    } else {
      return "Ups! something went wrong. Please try angain!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestObserverBloc, QuestObserverState>(
      buildWhen: (previous, current) =>previous != current,
        builder: (context, state) {
      if (state is QuestObserverInitial) {
        return const Placeholder();
      } else if (state is QuestObserverLoading) {
        return const SizedBox();
      } else if (state is QuestObserverFailure) {
        return Center(
          child: Text(
            mapFailure(state.questFailure),
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.redAccent),
          ),
        );
      } else if (state is QuestObserverSuccess) {
        return SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                  elevation: 16,
                  collapsedHeight: 70,
                  expandedHeight: 280,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  pinned: true,
                  flexibleSpace: const FlexibleSpace()),
              SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final quest = state.quests[index];
                      return QuestItem(
                        quest: quest,
                      );
                    }, childCount: state.quests.length),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            crossAxisSpacing: 20,
                            childAspectRatio: 4 / 5,
                            mainAxisSpacing: 20),
                  )),
              QeustStateManager(quests: state.quests)
            ],
          ),
        );
      }
      return const Placeholder();
    });
  }
}
