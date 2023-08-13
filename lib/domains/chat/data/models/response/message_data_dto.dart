import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDataDto {
  final String message;
  final String sender;
  final Timestamp time;

  MessageDataDto({
    required this.message,
    required this.sender,
    required this.time,
  });

  factory MessageDataDto.fromJson(Map<String, dynamic> json) => MessageDataDto(
        message: json['message'],
        sender: json['sender'],
        time: json['time'],
      );
}
