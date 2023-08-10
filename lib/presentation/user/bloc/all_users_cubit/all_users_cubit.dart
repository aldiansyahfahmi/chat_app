import 'package:chat_app/domains/user/domain/usecases/get_all_users_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'all_users_state.dart';

class AllUsersCubit extends Cubit<AllUsersState> {
  final GetAllUsersUseCase getAllUsersUseCase;

  AllUsersCubit({required this.getAllUsersUseCase})
      : super(AllUsersState(allUsersState: ViewData.initial()));

  void getAllUsers() async {
    emit(AllUsersState(allUsersState: ViewData.loading()));
    final result = await getAllUsersUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        AllUsersState(
          allUsersState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        AllUsersState(
          allUsersState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
