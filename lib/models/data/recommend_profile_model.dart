import 'dart:convert';

class RecommendProfileModel {
  // ToDo : 속성 API에 맞게 바꾸기
  // ToDo : 속성 바꾼 후에, recommend widget들에 들어가는 값도 맞추어 수정
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

  RecommendProfileModel(
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

  RecommendProfileModel.fromJsom(Map<String, dynamic> json) :
        userId = json['userId'],
        gender = json['gender'],
        nickname = json['nickname'],
        profilePhoto = json['profilePhoto'],
        birthday = json['birthday'],
        locationInfo = json['locationInfo'],
        mbti = json['mbti'],
        intro = json['intro'],
        // ToDo : List로 들어오는건 어떻게 넣어주어야 할지?
        hobby = jsonDecode(json['hobby']) ,
        interest = json['interest'],
        authenticatedAccount = json['authenticatedAccount'];
}