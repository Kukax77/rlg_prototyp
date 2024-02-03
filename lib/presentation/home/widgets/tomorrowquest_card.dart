import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/tomorrowquest/controller/controller_bloc.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/presentation/routes/router.gr.dart';

class TomorrowQuestCard extends StatelessWidget {
  final TomorrowQuest tomorrowQuest;
  const TomorrowQuestCard({super.key, required this.tomorrowQuest});

  void _showDeleteDialoge(
      {required BuildContext context, required ControllerBloc bloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selected TomorrowQuest to Delete"),
            content: Text(
              tomorrowQuest.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("CANCEL",
                      style: TextStyle(color: Colors.white))),
              TextButton(
                  onPressed: () {
                    bloc.add(
                        DeleteTomorrowquestEvent(tomorrowQuest: tomorrowQuest));
                    Navigator.pop(context);
                  },
                  child: const Text("DELETE",
                      style: TextStyle(color: Colors.white))),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themdata = Theme.of(context);
    return InkResponse(
      onLongPress: () {
        final controllerBloc = context.read<ControllerBloc>();
        _showDeleteDialoge(context: context, bloc: controllerBloc);
      },
      onTap: () {
        AutoRouter.of(context)
            .push(TomorrowQuestDetail(tomorrowQuest: tomorrowQuest));
      },
      child: Card(
        elevation: 16,
        color: themdata.colorScheme.secondary,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.59,
              child: ListTile(
                  title: Text(tomorrowQuest.title,
                      style: themdata.textTheme.headlineLarge!.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold))),
            ),
            TextButton(
                onPressed: () {
                  BlocProvider.of<ControllerBloc>(context).add(
                      ConvertTomorrowToQuestEvent(
                          tomorrowQuest: tomorrowQuest));
                },
                child: Text(
                  "test",
                  style: Theme.of(context).textTheme.bodyLarge,
                ))
          ],
        ),
      ),
    );
  }
}
