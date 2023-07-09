import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/widgets/chat/chat_listview.dart';
import 'package:wooyeon_flutter/widgets/chat/frequent_chatting.dart';
import 'package:wooyeon_flutter/widgets/chat/rounded_textfield.dart';

import '../../models/data/chat_room_data.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _Chat();
}

class _Chat extends State<Chat> {
  late List<ChatRoom> frequentChatting;

  @override
  void initState() {
    frequentChatting = List.from(chatRoomData);
    frequentChatting.sort((a, b) => a.frequent.compareTo(b.frequent));
    frequentChatting = frequentChatting.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RoundedTextField(
              hintText: '채팅방을 검색하세요',
              onSubmitted: (value) {
                log("Search : $value");
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("자주 대화하는 친구", style: TextStyle(
                color: Palette.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),textAlign: TextAlign.left,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FrequentChatting(frequentChatting),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("채팅", style: TextStyle(
                color: Palette.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),textAlign: TextAlign.left,),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ChatListView(chatRoomData),
            ),
          ),
        ],
      ),
    );
  }
}
