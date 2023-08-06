import 'package:chat_app/domains/auth/domain/usecases/get_token_usecase.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetTokenUseCase getTokenUseCase;
  SplashCubit({required this.getTokenUseCase})
      : super(SplashState(splashState: ViewData.initial()));

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final isTokenAvailable = await getTokenUseCase.call(const NoParams());
    isTokenAvailable.fold(
      (failure) => emit(
        SplashState(
          splashState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        SplashState(
          splashState: ViewData.loaded(),
        ),
      ),
    );
  }
}
