import 'package:chat_app/domains/chat/data/models/body/create_chat_room_request_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessageRequestDto {
  final CreateChatRoomRequestDto createChatRoomRequestDto;
  final String chatWith;
  final String message;

  SendMessageRequestDto({
    required this.createChatRoomRequestDto,
    required this.chatWith,
    required this.message,
  });

  Map<String, dynamic> toJson() => {
        'message': message,
        'sender': FirebaseAuth.instance.currentUser!.email,
        'time': Timestamp.now(),
      };
}
