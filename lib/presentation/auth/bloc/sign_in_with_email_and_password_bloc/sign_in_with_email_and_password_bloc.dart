import 'package:chat_app/domains/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'sign_in_with_email_and_password_state.dart';
import 'sign_in_with_email_and_password_event.dart';

class SignInWithEmailAndPasswordBloc extends Bloc<
    SignInWithEmailAndPasswordEvent, SignInWithEmailAndPasswordState> {
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;

  SignInWithEmailAndPasswordBloc(
      {required this.signInWithEmailAndPasswordUseCase})
      : super(
          SignInWithEmailAndPasswordState(
            signInWithEmailAndPasswordState: ViewData.initial(),
          ),
        ) {
    on<SignInWithEmailAndPassword>(
      (event, emit) async {
        emit(
          SignInWithEmailAndPasswordState(
            signInWithEmailAndPasswordState: ViewData.loading(),
          ),
        );
        final result = await signInWithEmailAndPasswordUseCase
            .call(event.authWithEmailAndPasswordRequestEntity);
        result.fold(
          (failure) async => emit(
            SignInWithEmailAndPasswordState(
              signInWithEmailAndPasswordState: ViewData.error(
                message: failure.errorMessage,
                failure: failure,
              ),
            ),
          ),
          (result) async {
            emit(
              SignInWithEmailAndPasswordState(
                signInWithEmailAndPasswordState: ViewData.loaded(data: result),
              ),
            );
          },
        );
      },
    );
  }
}
