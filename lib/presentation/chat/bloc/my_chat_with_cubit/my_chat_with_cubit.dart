import 'package:chat_app/domains/chat/domain/usecases/get_my_chat_with_usecase.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/shared_libraries/utils/navigation/arguments/my_chat_with_argument.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'my_chat_with_state.dart';

class MyChatWithCubit extends Cubit<MyChatWithState> {
  final GetMyChatWithUseCase getMyChatWithUseCase;

  MyChatWithCubit({required this.getMyChatWithUseCase})
      : super(MyChatWithState(myChatWithState: ViewData.initial()));

  void getMyChatWith({
    required UserDataEntity user,
    required String email,
  }) async {
    emit(MyChatWithState(myChatWithState: ViewData.loading()));
    final result = await getMyChatWithUseCase.call(email);
    result.fold(
      (failure) => emit(
        MyChatWithState(
          myChatWithState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        MyChatWithState(
          myChatWithState: ViewData.loaded(
            data: MyChatWithArgument(
              userDataEntity: user,
              result: result,
            ),
          ),
        ),
      ),
    );
  }
}
