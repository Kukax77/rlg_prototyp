import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/quest/questObserver/quest_observer_bloc.dart';
import 'package:rlg/application/tomorrowquest/tomorrowquestForm/tomorrowquest_form_bloc_bloc.dart';
import 'package:rlg/presentation/signup/signup_page/widgets/custom_button.dart';

class TomorrowquestDetailForm extends StatelessWidget {
  const TomorrowquestDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final textEditingControllerTitle = TextEditingController();
    final textEditingControllerBody = TextEditingController();

    late String body;
    late String title;

    String? validateBody(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a description!";
      } else if (input.length < 300) {
        body = input;
        return null;
      } else {
        return "body is too long";
      }
    }

    String? validateTitle(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter a description!";
      } else if (input.length < 30) {
        title = input;
        return null;
      } else {
        return "title is too long";
      }
    }

    return BlocConsumer<TomorrowquestFormBlocBloc, TomorrowquestFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingControllerTitle.text = state.tomorrowQuest.title;
        textEditingControllerBody.text = state.tomorrowQuest.body;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(children: [
              TextFormField(
                validator: validateTitle,
                controller: textEditingControllerTitle,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    label: const Text("Title..."),
                    counterText: "",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                maxLength: 100,
                maxLines: 2,
                minLines: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: validateBody,
                controller: textEditingControllerBody,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    label: const Text("Quest ..."),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    counterText: ""),
                maxLength: 300,
                maxLines: 8,
                minLines: 5,
              ),
              const SizedBox(height: 30),
              CustomButtonSI(
                  inhalt: "Save",
                  onTab: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<TomorrowquestFormBlocBloc>(context)
                          .add(TQSavedPressedEvent(title: title, body: body));
                      BlocProvider.of<QuestObserverBloc>(context).add(ObserveAllQuestsEvent());
                    } else {
                      BlocProvider.of<TomorrowquestFormBlocBloc>(context)
                          .add(TQSavedPressedEvent(title: null, body: null));

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Invalid Input",
                            style: Theme.of(context).textTheme.bodyLarge),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  })
            ]),
          ),
        );
      },
    );
  }
}
