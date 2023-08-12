import 'package:chat_app/domains/chat/domain/usecases/get_messages_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final GetMessagesUseCase getMessagesUseCase;

  MessagesCubit({required this.getMessagesUseCase})
      : super(MessagesState(messagesState: ViewData.initial()));

  void getMessages({required String chatId}) async {
    emit(MessagesState(messagesState: ViewData.loading()));
    final result = await getMessagesUseCase.call(chatId);
    result.fold(
      (failure) => emit(
        MessagesState(
          messagesState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        ),
      ),
      (result) => emit(
        MessagesState(
          messagesState: ViewData.loaded(
            data: result,
          ),
        ),
      ),
    );
  }
}
