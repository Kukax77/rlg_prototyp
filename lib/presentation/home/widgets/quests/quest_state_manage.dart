import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/management/points/controller/points_manager_bloc.dart';
import 'package:rlg/application/quest/questObserver/quest_observer_bloc.dart';
import 'package:rlg/domain/entities/quest.dart';
import 'package:timer_builder/timer_builder.dart';

class QeustStateManager extends StatelessWidget {
  final List<Quest> quests;
  const QeustStateManager({super.key, required this.quests});

  @override
  Widget build(BuildContext context) {
    if (quests.isNotEmpty) {
      final Timestamp? serverTimeStamp = quests[0].serverTimeStamp;
      return TimerBuilder.periodic(const Duration(minutes: 1),
          builder: (context) {
        if(serverTimeStamp !=null){final DateTime currenTime = DateTime.now();
        final DateTime date = serverTimeStamp.toDate();
        if (date.minute != currenTime.minute) {
          BlocProvider.of<PointsManagerBloc>(context)
              .add(GetQuestsToDeleteEvent(menge: -50, quests: quests));
          BlocProvider.of<QuestObserverBloc>(context).add(ObserveAllQuestsEvent());
        }
        return const SliverToBoxAdapter(child:  SizedBox());}
        else{return const SliverToBoxAdapter(child:  SizedBox());}
      });
    } else {
      return const SliverToBoxAdapter(child:  SizedBox());
    }
  }
}
