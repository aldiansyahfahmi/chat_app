class MyChatDataEntity {
  final String chatId;
  final String chatWith;
  final String lastMessage;
  final int totalUnread;

  MyChatDataEntity({
    required this.chatId,
    required this.chatWith,
    required this.lastMessage,
    required this.totalUnread,
  });
}
