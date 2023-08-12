import 'package:chat_app/domains/chat/data/models/body/send_message_request_dto.dart';
import 'package:chat_app/domains/chat/data/models/response/message_data_dto.dart';
import 'package:chat_app/domains/chat/data/models/response/my_chat_data_dto.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatRemoteDataSource {
  Future<Stream<List<MyChatDataDto>>> getMyChats();
  Future<void> sendMessage({required SendMessageRequestDto requestDto});
  Future<Stream<List<MessageDataDto>>> getMessages({required String chatId});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> sendMessage({required SendMessageRequestDto requestDto}) async {
    try {
      final chatDoc = await firestoreService.chatCollection.where(
        'participants',
        whereIn: [
          [
            auth.currentUser!.email,
            requestDto.chatWith,
          ],
          [
            requestDto.chatWith,
            auth.currentUser!.email,
          ],
        ],
      ).get();

      if (chatDoc.docs.isEmpty) {
        // create chat room
        final createChat = await firestoreService.chatCollection.add(
          requestDto.createChatRoomRequestDto.toJson(),
        );

        // create my chat with friend
        await firestoreService.usersCollection
            .doc(auth.currentUser!.email)
            .collection(AppConstants.appCollection.chats)
            .add(requestDto.createChatRoomRequestDto.createmyChatJson(
              chatId: createChat.id,
              chatWith: requestDto.chatWith,
            ));

        // create friend chat with me
        await firestoreService.usersCollection
            .doc(requestDto.chatWith)
            .collection(AppConstants.appCollection.chats)
            .add(requestDto.createChatRoomRequestDto.createmyChatJson(
              chatId: createChat.id,
              chatWith: auth.currentUser!.email!,
            ));
      } else {
        final myChat = await firestoreService.usersCollection
            .doc(auth.currentUser!.email)
            .collection(AppConstants.appCollection.chats)
            .where('chat_with', isEqualTo: requestDto.chatWith)
            .get();

        await firestoreService.chatCollection
            .doc(myChat.docs.first.data()['chat_id'])
            .update({'last_message': requestDto.message});

        await firestoreService.chatCollection
            .doc(myChat.docs.first.data()['chat_id'])
            .collection('messages')
            .add(requestDto.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<MyChatDataDto>>> getMyChats() async {
    try {
      final result = firestoreService.usersCollection
          .doc(auth.currentUser!.email)
          .collection(AppConstants.appCollection.chats)
          .snapshots();
      return result.map(
        (event) => List<MyChatDataDto>.from(
          event.docs.map(
            (e) => MyChatDataDto.fromJson(e.data()),
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<List<MessageDataDto>>> getMessages(
      {required String chatId}) async {
    try {
      final result = firestoreService.chatCollection
          .doc(chatId)
          .collection(AppConstants.appCollection.messages)
          .snapshots();
      return result.map(
        (event) => List<MessageDataDto>.from(
          event.docs.map(
            (e) => MessageDataDto.fromJson(e.data()),
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
