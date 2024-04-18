import 'package:chat_app/features/chat/application/chat_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_user/domain/entities/user.dart';
import '../../../app_user/presentation/widgets/app_user_info_view.dart';
import '../../domain/entities/chat.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const String path = "chatScreen";

  final User user;
  const ChatScreen({super.key, required this.user});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchChats();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _fetchChats() {
    ref.read(chatProvider.notifier).fetchChat(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            children: [
              AppUserInfoView(
                otherUser: widget.user,
              ),
              Expanded(child: _getBody()),
            ],
          ),
        ));
  }

  Widget _getBody() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildChatWindow(),
            ),
            _buildTextBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatWindow() {
    AsyncValue<List<Chat>> chats = ref.watch(chatProvider);
    return chats.when(
        data: (List<Chat> chats) {
          return ListView.builder(
            reverse: true, // Show newest messages at the top
            itemCount: chats.length,
            itemBuilder: (context, index) => _buildMessage(chats[index]),
          );
        },
        error: (e, s) => const SizedBox.shrink(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget _buildTextBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(hintText: 'Type your message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendMessage(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Chat chat) {
    return Align(
      alignment: _sentByMe(chat.receiver)
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: _sentByMe(chat.receiver) ? Colors.blue[200] : Colors.grey[200],
        ),
        child: Text(chat.message),
      ),
    );
  }

  bool _sentByMe(String receiverId) {
    return receiverId == widget.user.id;
  }

  void _sendMessage() {
    ref
        .read(chatProvider.notifier)
        .sendChat(widget.user, _messageController.text);
    _messageController.text = "";
  }
}
