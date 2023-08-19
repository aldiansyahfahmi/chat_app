import 'package:chat_app/domains/chat/domain/usecases/get_my_chats_usecase.dart';
import 'package:chat_app/domains/user/data/mapper/user_mapper.dart';
import 'package:chat_app/domains/user/data/models/response/user_data_dto.dart';
import 'package:chat_app/domains/user/domain/entities/response/user_data_entity.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import '/shared_libraries/utils/usecase/usecase.dart';
import 'my_chats_state.dart';

class MyChatsCubit extends Cubit<MyChatsState> {
  final GetMyChatsUseCase getMyChatsUseCase;

  MyChatsCubit({required this.getMyChatsUseCase})
      : super(MyChatsState(myChatsState: ViewData.initial()));

  void getMyChats() async {
    emit(MyChatsState(myChatsState: ViewData.loading()));
    final result = await getMyChatsUseCase.call(const NoParams());
    result.fold(
      (failure) => emit(
        MyChatsState(
          myChatsState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        MyChatsState(
          myChatsState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }

  Stream<UserDataEntity> getUser({required String userId}) {
    final result = FirestoreService().usersCollection.doc(userId).snapshots();
    return UserMapper().mapStreamUserDataDtoToStreamUserDataEntity(
      result.map(
        (event) => UserDataDto.fromJson(event.data()!),
      ),
    );
  }
}
