class MyChatDataDto {
  final String? chatId;
  final String? chatWith;
  final String? lastMessage;
  final int? totalUnread;

  MyChatDataDto({
    required this.chatId,
    required this.chatWith,
    required this.lastMessage,
    required this.totalUnread,
  });

  factory MyChatDataDto.fromJson(Map<String, dynamic> json) => MyChatDataDto(
        chatId: json['chat_id'],
        chatWith: json['chat_with'],
        lastMessage: json['last_message'],
        totalUnread: json['total_unread'],
      );
}
