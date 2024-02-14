class ChatData {
  int chatId;
  bool isSender;
  String message;
  DateTime sendTime;
  bool isCheck;

  ChatData(
      {required this.chatId,
      required this.isSender,
      required this.message,
      required this.sendTime,
      required this.isCheck});

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sendTime': sendTime,
      // Todo : 'sender': "my_uuid 혹은, jwt 토큰 사용 시 필요 없음"
      'sender': "my_uuid 혹은, jwt 토큰 사용 시 필요 없음"
    };
  }

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      chatId: -1,//json['chatId'],
      isSender: json['isSender'],
      message: json['message'],
      sendTime: DateTime.parse(json['sendTime']),
      isCheck: (json['isChecked'] == 1),
    );
  }
}

List<ChatData> chatDataList = [
  /// 적어도 Millisecond 까지 측정해야 채팅 정렬 가능
  /// 정렬 되어있다고 가정
  /// 정렬 알고리즘 필요 => 어느정도 정렬이 되어있을 가능성이 높으므로 삽입정렬 사용, 또는 보수적으로 퀵정렬 사용 예정
  ChatData(
      chatId: 0,
      isSender: true,
      message: '내가 보낸 메시지',
      sendTime: DateTime(2023, 7, 8, 10, 14, 32, 50),
      isCheck: true),
  ChatData(
      chatId: 1,
      isSender: true,
      message: '내가 보낸 메시지2',
      sendTime: DateTime(2023, 7, 8, 10, 14, 34, 50),
      isCheck: true),
  ChatData(
      chatId: 2,
      isSender: false,
      message: '상대가 보낸 메시지',
      sendTime: DateTime(2023, 7, 8, 10, 15, 32, 50),
      isCheck: true),
  ChatData(
      chatId: 3,
      isSender: true,
      message: '내가 보낸 중간 길이의 메시지',
      sendTime: DateTime(2023, 7, 8, 10, 16, 32, 50),
      isCheck: true),
  ChatData(
      chatId: 4,
      isSender: true,
      message: '짧은 메시지',
      sendTime: DateTime(2023, 7, 8, 10, 16, 37, 50),
      isCheck: true),
  ChatData(
      chatId: 5,
      isSender: true,
      message:
          '내가 보낸 긴 길이의 메시지. 최대 몇자까지 보여줄지는 아직 정해지지 않았음. 내가 보낸 긴 길이의 메시지. 최대 몇자까지 보여줄지는 아직 정해지지 않았음. 내가 보낸 긴 길이의 메시지. 최대 몇자까지 보여줄지는 아직 정해지지 않았음. 내가 보낸 긴 길이의 메시지. 최대 몇자까지 보여줄지는 아직 정해지지 않았음.',
      sendTime: DateTime(2023, 7, 8, 10, 17, 10, 50),
      isCheck: true),
  ChatData(
      chatId: 6,
      isSender: false,
      message: '상대가 보낸 중간 길이의 메시지',
      sendTime: DateTime(2023, 7, 8, 10, 17, 20, 50),
      isCheck: true),
  ChatData(
      chatId: 7,
      isSender: false,
      message: '상대가 보낸 중간 길이의 메시지2',
      sendTime: DateTime(2023, 7, 8, 10, 17, 30, 50),
      isCheck: true),
  ChatData(
      chatId: 8,
      isSender: false,
      message: '짧은 메시지',
      sendTime: DateTime(2023, 7, 8, 10, 17, 40, 50),
      isCheck: true),
  ChatData(
      chatId: 9,
      isSender: false,
      message: '상대가 보낸 약간 긴 길이의 메시지. 상대가 보낸 약간 긴 길이의 메시지.',
      sendTime: DateTime(2023, 7, 8, 10, 18, 32, 50),
      isCheck: true),
  ChatData(
      chatId: 10,
      isSender: true,
      message: '단답',
      sendTime: DateTime(2023, 7, 8, 12, 19, 32, 50),
      isCheck: true),
  ChatData(
      chatId: 11,
      isSender: true,
      message: 'ㅇ',
      sendTime: DateTime(2023, 7, 8, 12, 19, 35, 50),
      isCheck: true),
  ChatData(
      chatId: 12,
      isSender: false,
      message: '스크롤을\n위해서\n매우 긴\n채팅을\n일부러\n생성\n함',
      sendTime: DateTime(2023, 7, 8, 12, 20, 35, 50),
      isCheck: true),
  ChatData(
      chatId: 13,
      isSender: false,
      message: '스크롤을\n위해서\n매우 긴\n채팅을\n일부러\n생성\n함',
      sendTime: DateTime(2023, 7, 8, 12, 20, 40, 50),
      isCheck: true),
  ChatData(
      chatId: 14,
      isSender: false,
      message: '스크롤을\n위해서\n매우 긴\n채팅을\n일부러\n생성\n함',
      sendTime: DateTime(2023, 7, 8, 12, 21, 40, 50),
      isCheck: true),

  ChatData(
      chatId: 10,
      isSender: true,
      message: '날짜가 달라진 메시지',
      sendTime: DateTime(2023, 7, 9, 10, 19, 32, 50),
      isCheck: true),
  ChatData(
      chatId: 11,
      isSender: false,
      message: '확인 안한 메시지',
      sendTime: DateTime(2023, 7, 9, 10, 19, 50, 50),
      isCheck: false),
  ChatData(
      chatId: 12,
      isSender: false,
      message: '여기 처리부분 아직 모르겠음',
      sendTime: DateTime(2023, 7, 9, 10, 20, 10, 50),
      isCheck: false),
  ChatData(
      chatId: 13,
      isSender: false,
      message: '최근 채팅 메시지는 여기에 보이게 됩니다.',
      sendTime: DateTime(2023, 7, 9, 10, 20, 15, 50),
      isCheck: false),
];

List<ChatData> chatDataList_2 = [
  ChatData(
      chatId: 0,
      isSender: true,
      message: '내가 보낸 메시지',
      sendTime: DateTime(2023, 7, 7, 10, 14, 32, 50),
      isCheck: true),
];

List<ChatData> chatDataList_3 = [
  ChatData(
      chatId: 0,
      isSender: false,
      message: '상대가 보낸 메시지',
      sendTime: DateTime(2023, 6, 30, 10, 14, 32, 50),
      isCheck: true),
];

List<ChatData> chatDataList_4 = [
  ChatData(
      chatId: 0,
      isSender: false,
      message: '해당 페이지에서는 메시지가 길면 말줄임표가 붙게됩니다.',
      sendTime: DateTime(2022, 12, 8, 10, 14, 32, 50),
      isCheck: false),
];
