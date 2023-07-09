import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/widgets/chat/chat_list_item.dart';

import '../../models/data/chat_room_data.dart';

class ChatListView extends StatelessWidget {
  final List<ChatRoom> items;
  const ChatListView(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ChatListItem(items[index]),
            const SizedBox(height: 20,),
          ],
        );
      },
    );
  }
}
