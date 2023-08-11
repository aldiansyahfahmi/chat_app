import 'dart:developer';

import 'package:chat_app/domains/chat/data/models/body/create_chat_room_request_dto.dart';
import 'package:chat_app/domains/chat/data/models/response/my_chat_data_dto.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatRemoteDataSource {
  Future<Stream<List<MyChatDataDto>>> getMyChats();
  Future<void> sendMessage({required CreateChatRoomRequestDto requestDto});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> sendMessage(
      {required CreateChatRoomRequestDto requestDto}) async {
    try {
      final chatDoc = await firestoreService.chatCollection.where(
        'participants',
        whereIn: [
          [
            auth.currentUser!.email,
            requestDto.toEmail,
          ],
          [
            requestDto.toEmail,
            auth.currentUser!.email,
          ],
        ],
      ).get();

      if (chatDoc.docs.isEmpty) {
        final createChat =
            await firestoreService.chatCollection.add(requestDto.toJson());
        await firestoreService.usersCollection
            .doc(auth.currentUser!.email)
            .collection(AppConstants.appCollection.chat)
            .add({
          'chat_id': createChat.id,
          'chat_with': requestDto.toEmail,
        });
        await firestoreService.usersCollection
            .doc(requestDto.toEmail)
            .collection(AppConstants.appCollection.chat)
            .add({
          'chat_id': createChat.id,
          'chat_with': auth.currentUser!.email,
        });
      } else {
        String chatId = '';
        final myChat = await firestoreService.usersCollection
            .doc(auth.currentUser!.email)
            .collection(AppConstants.appCollection.chat)
            .where('chat_with', isEqualTo: requestDto.toEmail)
            .get();
        log(myChat.docs.first.data().values.toString());
        chatId = myChat.docs.first.data()['chat_id'];
        log('chat ID : $chatId');
        await firestoreService.chatCollection
            .doc(chatId)
            .collection('messages')
            .add({
          'message': 'Haloooooo',
          'sender': auth.currentUser!.email,
        });
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
          .collection(AppConstants.appCollection.chat)
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
}
