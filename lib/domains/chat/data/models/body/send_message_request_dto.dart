class SendMessageRequestDto {
  final String userId;
  final String message;
  final String sender;
  final String timestamp;
  final bool isRead;

  SendMessageRequestDto({
    required this.userId,
    required this.message,
    required this.sender,
    required this.timestamp,
    required this.isRead,
  });

  Map<String, dynamic> toJson() => {
        'message': message,
        'sender': sender,
        'timestamp': timestamp,
        'is_read': isRead,
      };
}
