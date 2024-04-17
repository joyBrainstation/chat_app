import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/chat/domain/entities/chat.dart';
import 'package:chat_app/features/chat/domain/use_cases/fetch_chat_use_case.dart';
import 'package:chat_app/features/chat/domain/use_cases/get_new_chat_stream_use_case.dart';
import 'package:chat_app/features/chat/domain/use_cases/send_chat_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/chat_room.dart';

final chatProvider =
    StateNotifierProvider.autoDispose<ChatNotifier, AsyncValue<List<Chat>>>(
        (ref) => ChatNotifier());

class ChatNotifier extends StateNotifier<AsyncValue<List<Chat>>> {
  ChatNotifier() : super(const AsyncLoading());
  String? chatRoomId;

  Future<void> sendChat(String uid, String message) async {
    SendChatUseCase useCase = SendChatUseCase();
    await useCase.call(uid, chatRoomId, message);
  }

  Future<void> fetchChat(String uid) async {
    FetchChatUseCase useCase = FetchChatUseCase();
    Either<ChatRoom, ErrorData> response = await useCase(uid);

    response.fold((ChatRoom chatRoom) {
      chatRoomId = chatRoom.id;
      state = AsyncData(chatRoom.chats);
    }, (ErrorData error) {
      debugPrint("error chat ${error.message}");
    });
    _listenToNewChat(uid);
  }

  void _listenToNewChat(String uid) {
    GetNewChatStreamUseCase useCase = GetNewChatStreamUseCase();
    Stream<List<Chat>> newChatStream = useCase(uid, chatRoomId);
    bool initial = true;
    newChatStream.listen((List<Chat> chats) {
      List<Chat> oldChats = state.value ?? [];
      if (initial) {
        chats = [];
        initial = false;
      }
      state = AsyncData([
        ...chats,
        ...oldChats,
      ]);
    });
  }
}
