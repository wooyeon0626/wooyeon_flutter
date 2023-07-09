import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/models/data/chat_room_data.dart';

class ChatDetail extends StatefulWidget {
  final ChatRoom chatRoom;
  const ChatDetail({required this.chatRoom, super.key});

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child:Text('채팅방')));
  }
}