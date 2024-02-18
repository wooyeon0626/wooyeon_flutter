import 'dart:convert';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:wooyeon_flutter/models/data/chat_data.dart';
import 'package:wooyeon_flutter/models/token_storage.dart';
import 'package:wooyeon_flutter/widgets/chat/bottom_sheet_textfield.dart';
import 'package:wooyeon_flutter/widgets/chat/chat_listview.dart';
import '../../config/config.dart';
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
  StompClient? stompClient;

  // on stomp connect 시 동작, subscribe callback 함수 등록
  Future<void> onConnect(StompFrame frame) async {
    stompClient!.subscribe(
      destination: '/queue/chat/room',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await TokenStorage().getToken()}',
      },
      // subscribe callback
      callback: (StompFrame frame) {
        if (frame.body != null) {
          Map<String, dynamic> obj = json.decode(frame.body!);
          ChatData chatData = ChatData.fromJson(obj);
          setState(
              () => chatController.addChatData(widget.chatRoomId, chatData));
        }
      },
    );
  }

  // stomp 를 통해 message 전송
  Future<void> sendMessage(
      {required int roomId, required String message}) async {
    stompClient!.send(
      destination: '/app/chat/message',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await TokenStorage().getToken()}',
      },
      body: jsonEncode(
        <String, dynamic>{'roomId': roomId, 'message': message, 'type': 'TALK'},
      ),
    );
  }

  // stomp 를 통해, backend 에게, ENTER 신호 전송
  Future<void> enterStomp({required int roomId}) async {
    stompClient!.send(
      // Todo : '/app/chat/message', 바꿔야 동작함
      destination: '/chat/message',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await TokenStorage().getToken()}',
      },
      body: jsonEncode(
        <String, dynamic>{'roomId': roomId, 'type': 'ENTER'},
      ),
    );
  }

  // stomp 를 통해, backend 에게, QUIT 신호 전송
  Future<void> quitStomp({required int roomId}) async {
    stompClient!.send(
      // Todo : '/app/chat/message', 바꿔야 동작함
      destination: '/chat/message',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await TokenStorage().getToken()}',
      },
      body: jsonEncode(
        <String, dynamic>{'roomId': roomId, 'type': 'QUIT'},
      ),
    );
  }

  // init stomp client, stomp 연결 시도
  Future<void> initStompClient() async {
    // init StompClient
    if (stompClient == null) {
      stompClient = StompClient(
        config: StompConfig.sockJS(
          url: '${Config.domain}/ws/chat',
          onConnect: onConnect,
          onWebSocketError: (dynamic error) => debugPrint(error.toString()),
          stompConnectHeaders: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await TokenStorage().getToken()}',
          },
          webSocketConnectHeaders: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await TokenStorage().getToken()}',
          },
        ),
      );
      stompClient!.activate();
    }
  }

  Future<void> activateAndEnterStomp(int roomId) async {
    // stomp 연결 시도
    await initStompClient();
    // stomp 를 통해, backend 에게, ENTER 신호 전송
    await enterStomp(roomId: roomId);
  }

  Future<void> quitAndDeactivateStomp(
      StompClient stompClient, int roomId) async {
    // stomp 를 통해, backend 에게, QUIT 신호 전송
    await quitStomp(roomId: roomId);
    // stomp client 연결 해제
    stompClient.deactivate();
  }

  @override
  void initState() {
    super.initState();
    chatController = Get.find<ChatController>();

    // API 를 통해, 특정 chatRoomId 에 대한, 채팅 데이터 load
    chatController.loadChatData(widget.chatRoomId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.markChatsAsChecked(widget.chatRoomId);
    });

    activateAndEnterStomp(widget.chatRoomId);
  }

  @override
  void dispose() {
    super.dispose();
    quitAndDeactivateStomp(stompClient!, widget.chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(130),
          child: SafeArea(
            child: Row(
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
                          backgroundImage: NetworkImage(controller
                              .chatRooms[widget.chatRoomId]!.profilePhoto),
                          radius: 36,
                        ),
                      ),
                      Text(
                        controller.chatRooms[widget.chatRoomId]!.nickname,
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
          ),
        ),
        body: GetBuilder<ChatController>(
          init: chatController,
          builder: (controller) {
            return Column(
              children: [
                if (controller.chatRooms[widget.chatRoomId]!.chat.isNotEmpty)
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
                        style:
                            TextStyle(color: Palette.lightGrey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ))),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomSheetTextField(
                    hintText: '메시지를 입력하세요',
                    onSubmitted: (String message) {
                      /**/ //Todo : 해당 부분 삭제
                      // ChatRoom room = controller.chatRooms[widget.chatRoomId]!;
                      //
                      // int newChatId =
                      //     room.chat.isEmpty ? 0 : room.chat.last.chatId + 1;
                      //
                      // ChatData newChat = ChatData(
                      //     chatId: newChatId,
                      //     isSender: true,
                      //     message: message,
                      //     sendTime: DateTime.now(),
                      //     isCheck: true);
                      //
                      // controller.addChatData(widget.chatRoomId, newChat);
                      /**/

                      /**/ //Todo : 해당 부분 추가
                      sendMessage(roomId: widget.chatRoomId, message: message);
                      /**/
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
