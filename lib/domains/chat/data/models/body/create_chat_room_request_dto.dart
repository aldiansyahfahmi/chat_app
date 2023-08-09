class CreateChatRoomRequestDto {
  final List<String> participants;
  final String toEmail;
  final String lastMessage;

  CreateChatRoomRequestDto({
    required this.participants,
    required this.toEmail,
    required this.lastMessage,
  });

  Map<String, dynamic> toJson() => {
        'participants': participants,
        'last_message': lastMessage,
      };
}
