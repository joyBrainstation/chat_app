import 'package:chat_app/core/components/data/models/error_response.dart';
import 'package:chat_app/features/chat/data/data_sources/chat_data_source.dart';
import 'package:chat_app/features/chat/data/models/chat_response.dart';
import 'package:chat_app/features/chat/data/models/chat_room_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatFirebaseDataSource extends ChatDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _chatRoomPath = "chatroom";
  final String _chatCollectionPath = "chat";

  @override
  Future<Either<ChatRoomResponse, ErrorResponse>> fetchChats(String uid) async {
    String? chatRoomId = await _getChatRoomId(uid);
    if (chatRoomId != null) {
      final QuerySnapshot snapshot = await _firestore
          .collection(_chatRoomPath)
          .doc(chatRoomId)
          .collection(_chatCollectionPath)
          .get();
      List<ChatResponse> chats = List<ChatResponse>.from(
        snapshot.docs.map(
          (doc) =>
              ChatResponse.fromJson(doc.data() as Map<String, dynamic>, doc.id),
        ),
      );

      ChatRoomResponse room = ChatRoomResponse(chatRoomId, chats);

      return Left(room);
    } else {
      return Right(ErrorResponse("No chat history found"));
    }
  }

  Future<String?> _getChatRoomId(String uid) async {
    List<String> possibleChatRoomIds = _getPossibleChatRoomId(uid);
    String? chatRoomId;
    for (String id in possibleChatRoomIds) {
      final DocumentSnapshot snapshot =
          await _firestore.collection(_chatRoomPath).doc(id).get();
      if (snapshot.exists) {
        chatRoomId = id;
        break;
      }
    }
    return chatRoomId;
  }

  List<String> _getPossibleChatRoomId(String uid) {
    String myId = _firebaseAuth.currentUser!.uid;
    return ["$myId-$uid", "$uid-$myId"];
  }

  @override
  Future<void> sendChat(String uid, String? chatRoomId, String message) async {
    chatRoomId = chatRoomId ?? _getPossibleChatRoomId(uid).first;
    Map<String, dynamic> payload = {
      "sender": _firebaseAuth.currentUser!.uid,
      "receiver": uid,
      "message": message,
      "time": DateTime.now(),
    };

    DocumentReference docRef =
        _firestore.collection(_chatRoomPath).doc(chatRoomId);
    await docRef.set({"id": chatRoomId});
    await docRef.collection(_chatCollectionPath).add(payload);
  }

  @override
  Stream<List<ChatResponse>> getNewChatStream(
    String uid,
    String? chatRoomId,

  ) {
    chatRoomId = chatRoomId ?? _getPossibleChatRoomId(uid).first;
    return _firestore
        .collection(_chatRoomPath)
        .doc(chatRoomId)
        .collection(_chatCollectionPath)
        .orderBy("time")
        .snapshots()
        .map(_getChatResponseFromSnapshot);
  }

  List<ChatResponse> _getChatResponseFromSnapshot(QuerySnapshot snapshot) {

    return snapshot.docChanges
        .map((doc) => ChatResponse.fromJson(
            doc.doc.data() as Map<String, dynamic>, doc.doc.id))
        .toList();
  }
}
