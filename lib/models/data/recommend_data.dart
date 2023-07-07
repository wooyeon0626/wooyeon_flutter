class RecommendProfiles {
  int userId;
  String gender;
  String nickname;
  List<String> profilePhoto;
  String birthday;
  String locationInfo;
  String? mbti;
  String? intro;
  List<String>? hobby;
  List<String>? interest;

  RecommendProfiles(
      {required this.userId,
      required this.gender,
      required this.nickname,
      required this.profilePhoto,
      required this.birthday,
      required this.locationInfo,
      this.mbti,
      this.intro,
      this.hobby,
      this.interest});
}

List<RecommendProfiles> recommendProfiles = [
  RecommendProfiles(
    userId: 1,
    gender: 'M',
    nickname: "유저1",
    profilePhoto: [
      "https://i.imgur.com/qPDIdlc.jpeg",
      "https://i.imgur.com/j0CFUxd.jpeg",
      "https://i.imgur.com/pbyO8uH.jpeg",
      "https://i.imgur.com/qPDIdlc.jpeg",
      "https://i.imgur.com/j0CFUxd.jpeg",
      "https://i.imgur.com/pbyO8uH.jpeg",
    ],
    birthday: '19990101',
    locationInfo: '서울시 관악구',
    mbti: 'INTP',
    interest: ['관심사1', '관심사2'],
    intro:
        '귀여운 여우입니다.\n자기소개 글 2줄까지 가능\n해당 페이지에서 추가적인 소개 글을 확인할 수 있습니다. 추가적인 자기소개.',
    hobby: ['취미1', '취미2', '취미3'],
  ),
  RecommendProfiles(
    userId: 2,
    gender: 'F',
    nickname: "유저2",
    profilePhoto: [
      "https://i.imgur.com/pbyO8uH.jpeg",
      "https://i.imgur.com/qPDIdlc.jpeg",
      "https://i.imgur.com/j0CFUxd.jpeg",
    ],
    birthday: '20010101',
    locationInfo: '서울시 강서구',
    mbti: 'ESFJ',
    interest: ['관심사1', '관심사2'],
    intro: '자기소개 글입니다.',
    hobby: ['취미1', '취미2', '취미3'],
  ),
  RecommendProfiles(
    userId: 3,
    gender: 'F',
    nickname: "유저3",
    profilePhoto: [
      "https://i.imgur.com/j0CFUxd.jpeg",
      "https://i.imgur.com/pbyO8uH.jpeg",
      "https://i.imgur.com/qPDIdlc.jpeg",
    ],
    birthday: '20010101',
    locationInfo: '서울시 강서구',
    mbti: 'ESFJ',
    interest: ['관심사1', '관심사2'],
    intro: '자기소개 글입니다.',
    hobby: ['취미1', '취미2', '취미3'],
  ),
];
