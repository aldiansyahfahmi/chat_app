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

  Map<String, dynamic> createmyChatJson({
    required String chatId,
    required String chatWith,
  }) =>
      {
        'chat_id': chatId,
        'chat_with': chatWith,
      };
}
