class MyChatDataDto {
  final String chatId;
  final String chatWith;

  MyChatDataDto({required this.chatId, required this.chatWith});

  factory MyChatDataDto.fromJson(Map<String, dynamic> json) => MyChatDataDto(
        chatId: json['chat_id'],
        chatWith: json['chat_with'],
      );
}
