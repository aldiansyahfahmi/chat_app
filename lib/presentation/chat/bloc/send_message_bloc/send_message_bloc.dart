import 'package:chat_app/domains/chat/domain/usecases/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared_libraries/utils/state/view_data_state.dart';
import 'send_message_state.dart';
import 'send_message_event.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final SendMessageUseCase sendMessageUseCase;

  SendMessageBloc({required this.sendMessageUseCase})
      : super(
          SendMessageState(
            sendMessageState: ViewData.initial(),
          ),
        ) {
    on<SendMessage>(
      (event, emit) async {
        emit(
          SendMessageState(
            sendMessageState: ViewData.loading(),
          ),
        );
        final result =
            await sendMessageUseCase.call(event.sendMessageRequestEntity);
        result.fold(
          (failure) async => emit(
            SendMessageState(
              sendMessageState: ViewData.error(
                message: failure.errorMessage,
                failure: failure,
              ),
            ),
          ),
          (result) async {
            emit(
              SendMessageState(
                sendMessageState: ViewData.loaded(data: result),
              ),
            );
          },
        );
      },
    );
  }
}
