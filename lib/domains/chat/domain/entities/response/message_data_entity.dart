import 'package:cloud_firestore/cloud_firestore.dart';

class MessageDataEntity {
  final String message;
  final String sender;
  final Timestamp time;

  MessageDataEntity({
    required this.message,
    required this.sender,
    required this.time,
  });
}
