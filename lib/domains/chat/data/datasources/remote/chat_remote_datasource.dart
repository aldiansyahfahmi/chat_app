import 'package:chat_app/domains/chat/data/models/body/send_message_request_dto.dart';
import 'package:chat_app/services/firestore_service.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage({required SendMessageRequestDto requestDto});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Future<void> sendMessage({required SendMessageRequestDto requestDto}) async {
    try {
      firestoreService
          .chatCollection(userId: requestDto.userId)
          .doc(requestDto.userId)
          .set(requestDto.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
