import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/activity/observerTwo/observer_two_bloc.dart';
import 'package:rlg/core/failures/quest_failures.dart';
import 'package:rlg/presentation/activity/widgets/activity.dart';
import 'package:rlg/presentation/activity/widgets/flexible_activity_space.dart';

class ActivityBody extends StatelessWidget {
  const ActivityBody({super.key});

  @override
  Widget build(BuildContext context) {

String mapFailure(QuestFailure failure) {
    if (failure is QuestInsufficientPermissions) {
      return "conection lost... please log back in!";
    } else {
      return "Ups! something went wrong. Please try angain!";
    }
  }

    return BlocBuilder<ObserverTwoBloc,ObserverTwoState>(builder: (context,state){


       if(state is ActivityObserverLoadingTwo){
        return const CircularProgressIndicator();
       }else if(state is ActivityObserverFailureTwo){
         return Center(
          child: Text(
            mapFailure(state.failure),
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Colors.redAccent),
          ),
        );
       }else if(state is ActivityObserverSuccessTwo){
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
                  flexibleSpace: const FlexibleActivitySpace()),
            const SliverToBoxAdapter(child: UnconstrainedBox(child: Activity()),)
            ],
          ),
        );
       }else{return const Placeholder();}
    });
   }
  
}