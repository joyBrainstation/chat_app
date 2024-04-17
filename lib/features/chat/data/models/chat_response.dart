import 'package:chat_app/features/chat/domain/entities/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatResponse {
  final String id;
  final String sender;
  final String receiver;
  final String message;
  final DateTime time;

  ChatResponse(this.id, this.sender, this.receiver, this.message, this.time);

  factory ChatResponse.fromJson(Map<String, dynamic> json, String docId) {
    Timestamp time = json["time"];
    return ChatResponse(
      docId,
      json["sender"],
      json["receiver"],
      json["message"],
      DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000),
    );
  }

  Chat toEntity() {
    return Chat(
      id: id,
      sender: sender,
      receiver: receiver,
      message: message,
      time: time,
    );
  }
}
