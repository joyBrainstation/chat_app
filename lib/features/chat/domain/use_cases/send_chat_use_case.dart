import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

import '../../../../config/service_locator/service_locator.dart';

class SendChatUseCase{
  Future<void> call(String uid, String? chatRoomId, String message)async{
    await sl<ChatRepository>().sendChat(uid, chatRoomId, message);
  }
}