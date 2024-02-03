import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/auth/signupform/sign_up_form_bloc.dart';
import 'package:rlg/injection.dart';
import 'package:rlg/presentation/signup/signup_page/widgets/signup_form.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<SignUpFormBloc>(), 
          child: const SignUpForm()),
    );
  }
}
