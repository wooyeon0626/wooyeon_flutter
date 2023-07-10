import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/widgets/chat/bottom_sheet_textfield.dart';
import 'package:wooyeon_flutter/widgets/chat/chat_listview.dart';

import '../../config/palette.dart';
import '../../models/controller/chat_controller.dart';

class ChatDetail extends StatefulWidget {
  final int chatRoomId;

  const ChatDetail({required this.chatRoomId, Key? key}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

class _ChatDetailState extends State<ChatDetail> {
  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController = Get.find<ChatController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.markChatsAsChecked(widget.chatRoomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(
                    EvaIcons.arrowIosBack,
                    color: Palette.black,
                  ),
                  iconSize: 36,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              GetBuilder<ChatController>(
                init: chatController,
                builder: (controller) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            controller.chatRooms[widget.chatRoomId]!.matched.profilePhoto[0]),
                        radius: 36,
                      ),
                    ),
                    Text(
                      controller.chatRooms[widget.chatRoomId]!.matched.nickname,
                      style: const TextStyle(
                          color: Palette.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Palette.black,
                    size: 36,
                  ),
                  onPressed: () {
                    // Handle more button press here.
                  },
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.5, // Add shadow to AppBar
          toolbarHeight: 130, // Increase AppBar height
        ),
        body: GetBuilder<ChatController>(
          init: chatController,
          builder: (controller) {
            return Column(
              children: [
                if (controller.chatRooms[widget.chatRoomId]!.chat != null && controller.chatRooms[widget.chatRoomId]!.chat!.isNotEmpty)
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ChatListView(widget.chatRoomId),
                    ),
                  )
                else
                  const Flexible(
                      fit: FlexFit.tight,
                      child: Center(
                          child: Text(
                            "대화가 없어요.\n친구에게 먼저 말을 걸어보세요!",
                            style: TextStyle(color: Palette.lightGrey, fontSize: 16),
                            textAlign: TextAlign.center,
                          ))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomSheetTextField(
                    hintText: '메시지를 입력하세요',
                    onSubmitted: (String value) {
                      controller.addMessage(widget.chatRoomId, value);
                    },
                  ),
                ),
              ],
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
