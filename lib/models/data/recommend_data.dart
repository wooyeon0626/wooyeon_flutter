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
  bool authenticatedAccount;

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
      this.interest,
      required this.authenticatedAccount,});
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
    ],
    birthday: '19990101',
    locationInfo: '서울시 관악구',
    mbti: 'INTP',
    interest: ['관심사1', '관심사2'],
    intro:
        '귀여운 여우입니다.\n자기소개 글 2줄까지 가능\n해당 페이지에서 추가적인 소개 글을 확인할 수 있습니다. 추가적인 자기소개.',
    hobby: ['취미1', '취미2', '취미3'],
    authenticatedAccount: true,
  ),
  RecommendProfiles(
    userId: 2,
    gender: 'F',
    nickname: "DOGE",
    profilePhoto: [
      "https://i.imgur.com/KpPiNC7.jpeg",
      "https://i.imgur.com/mMnGjwj.jpeg",
      "https://i.imgur.com/davfsYn.jpeg",
      "https://i.imgur.com/5YSm4ka.jpeg",
      "https://i.imgur.com/nWtb9ME.jpeg",
    ],
    birthday: '20010101',
    locationInfo: '서울시 강서구',
    mbti: 'ESFJ',
    interest: ['관심사1', '관심사2'],
    intro:
        '프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다.프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다. 프로필 자기소개 글 테스트. 몇 자까지 가능한지 테스트합니다.',
    hobby: ['취미1', '취미2', '취미3'],
    authenticatedAccount: false,
  ),
  RecommendProfiles(
    userId: 3,
    gender: 'F',
    nickname: "점메추",
    profilePhoto: [
      "https://i.imgur.com/jNRHEsz.png",
    ],
    birthday: '19950101',
    locationInfo: '제주도 서귀포시',
    mbti: 'ENTP',
    interest: ['관심사1', '관심사2'],
    intro: '프로필 이미지 1개 테스트',
    hobby: ['취미1', '취미2', '취미3'],
    authenticatedAccount: true,
  ),
  RecommendProfiles(
    userId: 4,
    gender: 'M',
    nickname: "닉네임 최대 몇 자?",
    profilePhoto: [
      "https://i.imgur.com/eMMDrp2.jpeg",
      "https://i.imgur.com/qrtX0cK.jpeg",
      "https://i.imgur.com/5elVgyA.jpeg",
      "https://i.imgur.com/Mpm9OHy.jpeg",
      "https://i.imgur.com/Ty1rJJX.jpeg",
      "https://i.imgur.com/eMMDrp2.jpeg",
      "https://i.imgur.com/qrtX0cK.jpeg",
      "https://i.imgur.com/5elVgyA.jpeg",
      "https://i.imgur.com/Mpm9OHy.jpeg",
      "https://i.imgur.com/Ty1rJJX.jpeg",
    ],
    birthday: '19980101',
    locationInfo: '부산시 부산진구',
    authenticatedAccount: false,
  ),
  RecommendProfiles(
    userId: 5,
    gender: 'M',
    nickname: "GIF",
    profilePhoto: [
      "https://i.imgur.com/KU3Ls9b.gif",
      "https://i.imgur.com/5BUdZ5u.jpeg",
    ],
    birthday: '19980101',
    locationInfo: '광주시 남구',
    mbti: 'ESFP',
    interest: ['관심사1', '관심사2'],
    intro: '프로필 이미지에는 animated gif도 가능합니다.',
    hobby: ['취미1', '취미2', '취미3'],
    authenticatedAccount: true,
  ),
];
