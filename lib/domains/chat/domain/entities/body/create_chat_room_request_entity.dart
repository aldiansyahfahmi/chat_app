class CreateChatRoomRequestEntity {
  final List<String> participants;
  final String lastMessage;

  CreateChatRoomRequestEntity({
    required this.participants,
    required this.lastMessage,
  });
}
