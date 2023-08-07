import 'package:chat_app/domains/auth/domain/usecases/is_user_logged_usecase.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final IsUserLoggedUseCase isUserLoggedUseCase;
  SplashCubit({required this.isUserLoggedUseCase})
      : super(SplashState(splashState: ViewData.initial()));

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final isUserLogged = await isUserLoggedUseCase.call(const NoParams());
    isUserLogged.fold(
      (failure) => emit(
        SplashState(
          splashState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) {
        if (result == true) {
          emit(
            SplashState(
              splashState: ViewData.loaded(),
            ),
          );
        } else {
          emit(
            SplashState(
              splashState: ViewData.noData(message: ''),
            ),
          );
        }
      },
    );
  }
}
