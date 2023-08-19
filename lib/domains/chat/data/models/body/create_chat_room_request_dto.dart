class CreateChatRoomRequestDto {
  final List<String> participants;
  final String lastMessage;

  CreateChatRoomRequestDto({
    required this.participants,
    required this.lastMessage,
  });

  Map<String, dynamic> toJson() => {
        'participants': participants,
        'last_message': lastMessage,
      };

  Map<String, dynamic> createMyChatJson({
    required String chatId,
    required String chatWith,
    required String lastMessage,
    required int totalUnread,
  }) =>
      {
        'chat_id': chatId,
        'chat_with': chatWith,
        'last_message': lastMessage,
        'total_unread': totalUnread,
      };
}
