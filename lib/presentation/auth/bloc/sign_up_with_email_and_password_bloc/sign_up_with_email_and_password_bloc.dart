import 'package:chat_app/domains/auth/domain/usecases/sign_up_with_email_and_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'sign_up_with_email_and_password_state.dart';
import 'sign_up_with_email_and_password_event.dart';

class SignUpWithEmailAndPasswordBloc extends Bloc<
    SignUpWithEmailAndPasswordEvent, SignUpWithEmailAndPasswordState> {
  final SignUpWithEmailAndPasswordUseCase signUpWithEmailAndPasswordUseCase;

  SignUpWithEmailAndPasswordBloc(
      {required this.signUpWithEmailAndPasswordUseCase})
      : super(
          SignUpWithEmailAndPasswordState(
            signUpWithEmailAndPasswordState: ViewData.initial(),
          ),
        ) {
    on<SignUpWithEmailAndPassword>(
      (event, emit) async {
        emit(
          SignUpWithEmailAndPasswordState(
            signUpWithEmailAndPasswordState: ViewData.loading(),
          ),
        );
        final result = await signUpWithEmailAndPasswordUseCase
            .call(event.signUpWithEmailAndPasswordRequestEntity);
        result.fold(
          (failure) async => emit(
            SignUpWithEmailAndPasswordState(
              signUpWithEmailAndPasswordState: ViewData.error(
                message: failure.errorMessage,
                failure: failure,
              ),
            ),
          ),
          (result) async {
            emit(
              SignUpWithEmailAndPasswordState(
                signUpWithEmailAndPasswordState: ViewData.loaded(data: result),
              ),
            );
          },
        );
      },
    );
  }
}
