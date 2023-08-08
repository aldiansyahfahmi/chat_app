import 'package:chat_app/domains/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase getSignOutUseCase;

  SignOutCubit({required this.getSignOutUseCase})
      : super(SignOutState(signOutState: ViewData.initial()));

  void signOut() async {
    emit(SignOutState(signOutState: ViewData.loading()));
    final result = await getSignOutUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        SignOutState(
          signOutState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        SignOutState(
          signOutState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
