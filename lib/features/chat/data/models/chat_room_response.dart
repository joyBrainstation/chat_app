import 'package:chat_app/features/chat/domain/entities/chat.dart';
import 'package:chat_app/features/chat/domain/entities/chat_room.dart';

import 'chat_response.dart';

class ChatRoomResponse {
  final String id;
  final List<ChatResponse> chats;

  ChatRoomResponse(this.id, this.chats);

  ChatRoom toEntity() {
    return ChatRoom(
      id: id,
      chats: List<Chat>.from(
        chats.map(
          (e) => e.toEntity(),
        ),
      ),
    );
  }
}
