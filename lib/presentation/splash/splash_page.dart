import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rlg/application/auth/auth_bloc/auth_bloc.dart';
import 'package:rlg/presentation/routes/router.gr.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          context.router.replace(const HomeRoute());
        } else {
          context.router.replace(const SignUpRoute());
        }
      },
      child: Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        )),
      ),
    );
  }
}
