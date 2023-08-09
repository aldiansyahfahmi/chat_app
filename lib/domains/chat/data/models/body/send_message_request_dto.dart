class SendMessageRequestDto {
  final String toEmail;
  final String userId;
  final String message;
  final String sender;
  final String timestamp;
  final bool isRead;

  SendMessageRequestDto({
    required this.toEmail,
    required this.userId,
    required this.message,
    required this.sender,
    required this.timestamp,
    required this.isRead,
  });

  Map<String, dynamic> toJson() => {
        'to_email': toEmail,
        'message': message,
        'sender': sender,
        'timestamp': timestamp,
        'is_read': isRead,
      };
}
