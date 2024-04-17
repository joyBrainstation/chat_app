import 'package:chat_app/core/components/domain/entity/error_data.dart';
import 'package:chat_app/features/chat/domain/entities/chat_room.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../config/service_locator/service_locator.dart';

class FetchChatUseCase{
  Future<Either<ChatRoom, ErrorData>> call(String uid)async{
    return sl<ChatRepository>().fetchChats(uid);
  }
}