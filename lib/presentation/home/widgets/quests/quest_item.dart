import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/management/points/controller/points_manager_bloc.dart';
import 'package:rlg/application/quest/questController/quest_controller_bloc.dart';
import 'package:rlg/domain/entities/quest.dart';

class QuestItem extends StatelessWidget {
  final Quest quest;
  const QuestItem(
      {super.key, required this.quest});

  @override
  Widget build(BuildContext context) {
    final themdata = Theme.of(context);
    return Material(
        elevation: 16,
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: themdata.colorScheme.secondary,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quest.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: themdata.textTheme.headlineLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  quest.body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: themdata.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          shape: const CircleBorder(),
                          activeColor: Colors.white,
                          checkColor: themdata.scaffoldBackgroundColor,
                          value: quest.done,
                          onChanged: (value) {
                            BlocProvider.of<QuestControllerBloc>(context).add(
                                UpdateQuestEvent(quest: quest, done: value!));
                            BlocProvider.of<PointsManagerBloc>(context).
                            add(PointsUpdatingEvent(menge: 10));
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
