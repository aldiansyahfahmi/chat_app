import 'package:chat_app/domains/account/domain/usecases/get_user_by_id_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'user_by_id_state.dart';

class UserByIdCubit extends Cubit<UserByIdState> {
  final GetUserByIdUseCase getUserByIdUseCase;

  UserByIdCubit({required this.getUserByIdUseCase})
      : super(UserByIdState(userByIdState: ViewData.initial()));

  void getUserById({required String docId}) async {
    emit(UserByIdState(userByIdState: ViewData.loading()));
    final result = await getUserByIdUseCase.call(docId);
    result.fold(
      (failure) => emit(
        UserByIdState(
          userByIdState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => result.listen(
        (event) {
          emit(
            UserByIdState(
              userByIdState: ViewData.loaded(
                data: result,
              ),
            ),
          );
        },
      ),
    );
  }
}
