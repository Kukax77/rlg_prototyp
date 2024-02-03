import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rlg/core/failures/auth_failures.dart';
import 'package:rlg/domain/repositories/auth_repository.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthRepository authRepository;
  SignUpFormBloc({required this.authRepository})
      : super((SignUpFormState(
            isSubmitting: false,
            showValidationMessages: false,
            authFailureOrSuccessOption: none()))) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(SignUpFormState(
            isSubmitting: false,
            showValidationMessages: true,
            authFailureOrSuccessOption: none()));
      } else {
        emit(SignUpFormState(
            isSubmitting: true,
            showValidationMessages: false,
            authFailureOrSuccessOption: none()));
        //toDO: trigger auth
        final falilureOrSuccess =
            await authRepository.registerWithEmailAndPassword(
                email: event.email!, password: event.password!);
        emit(SignUpFormState(
            isSubmitting: false,
            showValidationMessages: false,
            authFailureOrSuccessOption: optionOf(falilureOrSuccess)));
      }
    });

    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(SignUpFormState(
            isSubmitting: false,
            showValidationMessages: true,
            authFailureOrSuccessOption: none()));
      } else {
        emit(SignUpFormState(
            isSubmitting: true,
            showValidationMessages: false,
            authFailureOrSuccessOption: none()));
        //toDO: trigger auth
        final falilureOrSuccess =
            await authRepository.signInWithEmailAndPassword(
                email: event.email!, password: event.password!);
        emit(SignUpFormState(
            isSubmitting: false,
            showValidationMessages: false,
            authFailureOrSuccessOption: optionOf(falilureOrSuccess)));
      }
    });
  }
}
