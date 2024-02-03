import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/tomorrowquest/tomorrowquestForm/tomorrowquest_form_bloc_bloc.dart';
import 'package:rlg/core/failures/tomorrowquest_failures.dart';
import 'package:rlg/domain/entities/tomorrowquest.dart';
import 'package:rlg/injection.dart';
import 'package:rlg/presentation/routes/router.gr.dart';
import 'package:rlg/presentation/tomorrowquest_detail/widgets/save_progress_overlay.dart';
import 'package:rlg/presentation/tomorrowquest_detail/widgets/tomorrowquestDetailForm.dart/tomorowquest_detail_form.dart';

@RoutePage()
class TomorrowQuestDetail extends StatelessWidget {
  final TomorrowQuest? tomorrowQuest;
  const TomorrowQuestDetail({super.key, required this.tomorrowQuest});

  @override
  Widget build(BuildContext context) {
    final themData = Theme.of(context);

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

    return BlocProvider(
      create: (context) => sl<TomorrowquestFormBlocBloc>()
        ..add(InitializeTomorowquestDetailPage(tomorrowQuest: tomorrowQuest)),
      child: BlocConsumer<TomorrowquestFormBlocBloc, TomorrowquestFormState>(
        listenWhen: (previous, current) =>
            previous.failureOrSuccessOption != current.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
              () {},
              (a) => a.fold(
                  (failure) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(getFailureMessage(failure)),
                        backgroundColor: Colors.redAccent,
                      )),
                  (_) => Navigator.of(context).popUntil(
                      (route) => route.settings.name == HomeRoute.name)));
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                tomorrowQuest == null ? "Create Quest" : "Edit Quest",
                style: themData.textTheme.headlineLarge,
              ),
            ),
            body: Stack(
              children: [
                const TomorrowquestDetailForm(),
                SafeInProgressOverlay(isSaving: state.isSaving)
              ],
            ),
          );
        },
      ),
    );
  }
}
