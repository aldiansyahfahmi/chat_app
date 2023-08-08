import 'package:chat_app/domains/user/domain/usecases/get_user_by_id_usecase.dart';
import 'package:chat_app/domains/user/domain/usecases/get_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUseCase getUserUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;

  UserCubit({
    required this.getUserUseCase,
    required this.getUserByIdUseCase,
  }) : super(UserState(userState: ViewData.initial()));

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
      (result) async {
        final userById = await getUserByIdUseCase.call(const NoParams());
        userById.fold(
          (failure) {
            emit(
              UserState(
                userState: ViewData.error(
                  message: failure.errorMessage,
                  failure: failure,
                ),
              ),
            );
          },
          (resultUserById) {
            resultUserById.listen(
              (data) {
                emit(
                  UserState(
                    userState: ViewData.loaded(
                      data: data,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
