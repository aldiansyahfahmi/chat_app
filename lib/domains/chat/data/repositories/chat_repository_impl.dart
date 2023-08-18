import 'package:chat_app/domains/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:chat_app/domains/chat/data/mapper/chat_mapper.dart';
import 'package:chat_app/domains/chat/domain/entities/body/send_message_request_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/message_data_entity.dart';
import 'package:chat_app/domains/chat/domain/entities/response/my_chat_data_entity.dart';
import 'package:chat_app/domains/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/shared_libraries/utils/error/failure_response.dart';
import 'package:chat_app/shared_libraries/utils/usecase/usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSoure;
  final ChatMapper chatMapper;

  ChatRepositoryImpl({
    required this.chatRemoteDataSoure,
    required this.chatMapper,
  });

  @override
  Future<Either<FailureResponse, NoParams>> sendMessage(
      {required SendMessageRequestEntity requestEntity}) async {
    try {
      await chatRemoteDataSoure.sendMessage(
        requestDto:
            chatMapper.mapSendMessageRequestEntityToSendMessageRequestDto(
          requestEntity,
        ),
      );
      return const Right(NoParams());
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, Stream<List<MyChatDataEntity>>>>
      getMyChats() async {
    try {
      final result = await chatRemoteDataSoure.getMyChats();
      return Right(chatMapper.mapStreamMyChatDataDtoToStreamEntity(result));
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, Stream<List<MessageDataEntity>>>> getMessages(
      {required String chatId}) async {
    try {
      final result = await chatRemoteDataSoure.getMessages(chatId: chatId);
      return Right(chatMapper.mapStreamMessageDataDtoToStreamEntity(result));
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<MyChatDataEntity>>> getMyChatWith(
      {required String email}) async {
    try {
      final result = await chatRemoteDataSoure.getMyChatWith(email: email);
      return Right(
        chatMapper.mapMyChatDataDtoToEntity(result),
      );
    } on FirebaseException catch (error) {
      return Left(
        FailureResponse(
          errorMessage: error.message!,
          statusCode: 500,
        ),
      );
    }
  }
}
