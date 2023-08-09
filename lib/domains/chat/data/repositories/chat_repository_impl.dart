import 'package:chat_app/domains/chat/data/datasources/remote/chat_remote_datasource.dart';
import 'package:chat_app/domains/chat/data/mapper/chat_mapper.dart';
import 'package:chat_app/domains/chat/domain/entities/body/create_chat_room_request_entity.dart';
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
      {required CreateChatRoomRequestEntity requestEntity}) async {
    try {
      await chatRemoteDataSoure.sendMessage(
        requestDto:
            chatMapper.mapCreateChatRoomRequestEntityToCreateChatRoomRequestDto(
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
}
