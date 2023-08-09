class CreateChatRoomRequestEntity {
  final List<String> participants;
  final String toEmail;
  final String lastMessage;

  CreateChatRoomRequestEntity({
    required this.participants,
    required this.toEmail,
    required this.lastMessage,
  });
}
