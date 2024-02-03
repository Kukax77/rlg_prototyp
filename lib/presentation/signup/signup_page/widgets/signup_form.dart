import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/auth/signupform/sign_up_form_bloc.dart';
import 'package:rlg/core/failures/auth_failures.dart';
import 'package:rlg/presentation/routes/router.gr.dart';
import 'package:rlg/presentation/signup/signup_page/widgets/custom_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    late String email;
    late String password;

    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
      if (input == null || input.isEmpty) {
        return "please enter e-mail";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        email = input;
        return null;
      } else {
        return "invalid e-mail format";
      }
    }

    String? validatePasswort(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter password";
      } else if (input.length <= 6) {
        return "password is like your Dick ... :D";
      } else {
        password = input;
        return null;
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong - maby check your conection";
        case EmailAlredyInUseFailure:
          return "email is alredy in use";
        case InvalidEmailAndPasswordCombinationFailure:
          return "invalid email and password combination";
        default:
          return "Ups! something went wrong...";
      }
    }

    final themeData = Theme.of(context);

    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listenWhen: (previous, current) => previous.authFailureOrSuccessOption!= current.authFailureOrSuccessOption,
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
            (failure) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                mapFailureMessage(failure),
                style: themeData.textTheme.bodyLarge!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.redAccent,
            )),
            (_) => AutoRouter.of(context).replace(const HomeRoute()),
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formkey,
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text("Welcome",
                    style: themeData.textTheme.headlineLarge!.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 4)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Please Sign in or register",
                  style: themeData.textTheme.headlineLarge!.copyWith(
                    letterSpacing: 4,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(labelText: "E-Mail"),
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: validatePasswort,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButtonSI(
                  inhalt: "Sign up",
                  onTab: () {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<SignUpFormBloc>(context).add(
                          SignInWithEmailAndPasswordPressed(
                              email: email, password: password));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Invalid e-mail password combination",
                          style: themeData.textTheme.bodyLarge!.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.redAccent,
                      ));

                      BlocProvider.of<SignUpFormBloc>(context).add(
                          SignInWithEmailAndPasswordPressed(
                              email: null, password: null));
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonSI(
                  inhalt: "Register",
                  onTab: () {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<SignUpFormBloc>(context).add(
                          RegisterWithEmailAndPasswordPressed(
                              email: email, password: password));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Invalid e-mail or password",
                          style: themeData.textTheme.bodyLarge!.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.redAccent,
                      ));

                      BlocProvider.of<SignUpFormBloc>(context).add(
                          RegisterWithEmailAndPasswordPressed(
                              email: null, password: null));
                    }
                  },
                ),
                if (state.isSubmitting) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  LinearProgressIndicator(
                    color: themeData.colorScheme.secondary,
                  )
                ],
              ]),
        );
      },
    );
  }
}
