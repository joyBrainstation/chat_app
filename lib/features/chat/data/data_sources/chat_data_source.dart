
import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/chat/data/models/chat_response.dart';
import 'package:chat_app/features/chat/data/models/chat_room_response.dart';
import 'package:dartz/dartz.dart';

abstract class ChatDataSource{
Future<Either<ChatRoomResponse, ErrorResponse>> fetchChats(String uid);
Future<void> sendChat(String uid, String? chatRoomId, String message);
Stream<List<ChatResponse>> getNewChatStream(String uid, String? chatRoomId);
}