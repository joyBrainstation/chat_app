import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/chat/data/data_sources/chat_data_source.dart';
import 'package:chat_app/features/chat/data/models/chat_room_response.dart';
import 'package:chat_app/features/chat/domain/entities/chat.dart';
import 'package:chat_app/features/chat/domain/entities/chat_room.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatDataSource _chatDataSource;
  ChatRepositoryImpl(this._chatDataSource);
  @override
  Future<Either<ChatRoom, ErrorData>> fetchChats(String uid) async {
    Either<ChatRoomResponse, ErrorResponse> response =
        await _chatDataSource.fetchChats(uid);
    return response.fold(
      (ChatRoomResponse chatRoomResponse) => Left(
        chatRoomResponse.toEntity(),
      ),
      (ErrorResponse error) => Right(
        error.toEntity(),
      ),
    );
  }

  @override
  Stream<List<Chat>> getNewChatStream(String uid, String? chatRoomId) {
    return _chatDataSource
        .getNewChatStream(uid, chatRoomId)
        .map((event) => event.map((e) => e.toEntity()).toList());
  }

  @override
  Future<void> sendChat(String uid, String? chatRoomId, String message) async {
    await _chatDataSource.sendChat(uid, chatRoomId, message);
  }
}
