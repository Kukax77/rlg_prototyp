part of 'sign_up_form_bloc.dart';

class SignUpFormState {

  final bool isSubmitting;
  final bool showValidationMessages;
  final Option<Either<AuthFailure,Unit>> authFailureOrSuccessOption;

  SignUpFormState({required this.isSubmitting, required this.showValidationMessages, required this.authFailureOrSuccessOption});
}

