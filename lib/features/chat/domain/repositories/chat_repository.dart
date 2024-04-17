import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/chat/domain/entities/chat_room.dart';
import 'package:dartz/dartz.dart';

import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Either<ChatRoom, ErrorData>> fetchChats(String uid);
  Future<void> sendChat(String uid, String? chatRoomId, String message);
  Stream<List<Chat>> getNewChatStream(String uid, String? chatRoomId);
}
