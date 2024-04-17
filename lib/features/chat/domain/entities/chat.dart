class Chat {
  final String id;
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;

  Chat({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.time,
  });
}
