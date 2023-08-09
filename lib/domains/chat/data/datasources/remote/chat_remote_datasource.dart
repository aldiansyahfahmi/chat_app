import 'dart:developer';

import 'package:chat_app/domains/chat/data/models/body/create_chat_room_request_dto.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage({required CreateChatRoomRequestDto requestDto});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> sendMessage(
      {required CreateChatRoomRequestDto requestDto}) async {
    try {
      final chatCol = await firestoreService.chatCollection.get();
      if (chatCol.docs.isEmpty) {
        log('Chat kosong');
        final result =
            await firestoreService.chatCollection.add(requestDto.toJson());
        await firestoreService.usersCollection
            .doc(
          auth.currentUser!.email,
        )
            .update({
          'chats': [
            {
              'chat_id': result.id,
            },
          ],
        });

        await firestoreService.usersCollection
            .doc(
          requestDto.toEmail,
        )
            .update({
          'chats': [
            {
              'chat_id': result.id,
            },
          ],
        });
      } else {
        log('Chat tidak kosong');
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
          await firestoreService.chatCollection.add(requestDto.toJson());
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
