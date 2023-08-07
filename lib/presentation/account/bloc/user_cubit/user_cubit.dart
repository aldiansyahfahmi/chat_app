import 'package:chat_app/domains/account/domain/usecases/get_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUseCase getUserUseCase;

  UserCubit({required this.getUserUseCase})
      : super(UserState(userState: ViewData.initial()));

  void getUser() async {
    emit(UserState(userState: ViewData.loading()));
    final result = await getUserUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        UserState(
          userState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        UserState(
          userState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
