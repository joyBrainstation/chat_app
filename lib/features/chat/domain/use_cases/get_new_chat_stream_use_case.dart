import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../entities/chat.dart';

class GetNewChatStreamUseCase{
  Stream<List<Chat>> call(String uid, String? chatRoomId){
    return sl<ChatRepository>().getNewChatStream(uid, chatRoomId);
  }
}