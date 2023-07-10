import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wooyeon_flutter/config/palette.dart';

import '../../models/data/chat_data.dart';

class ChatListItem extends StatelessWidget {
  final ChatData chat;
  final bool isContinuous;

  const ChatListItem(this.chat, this.isContinuous, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: chat.isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: chat.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (chat.isSender)
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  DateFormat('hh:mm a').format(chat.sendTime),
                  style: const TextStyle(color: Palette.black, fontSize: 10),
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: chat.isSender ? const Radius.circular(20) : (isContinuous ? const Radius.circular(5) : const Radius.circular(20)),
                  topRight: chat.isSender ? (isContinuous ? const Radius.circular(5) : const Radius.circular(20)) : const Radius.circular(20),
                  bottomLeft: chat.isSender ? const Radius.circular(20) : const Radius.circular(5),
                  bottomRight: chat.isSender ? const Radius.circular(5) : const Radius.circular(20),
                ),
                color: chat.isSender ? Palette.secondary : Palette.inactive,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(chat.message, style: TextStyle(color: chat.isSender ? Colors.white : Palette.black,)),
              ),
            ),
            if (!chat.isSender)
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  DateFormat('hh:mm a').format(chat.sendTime),
                  style: const TextStyle(color: Palette.black, fontSize: 10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
