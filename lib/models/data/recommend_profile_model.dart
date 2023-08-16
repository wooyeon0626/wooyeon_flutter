class RecommendProfileModel {
  // ToDo : 속성 API에 맞게 바꾸기
  // ToDo : 속성 바꾼 후에, recommend widget들에 들어가는 값도 맞추어 수정
  //int userId;
  int profileId;
  String gender;
  String nickname;
  String birthday;
  String locationInfo;
  String gpsLocationInfo;
  String? mbti;
  String? intro;
  //bool authenticatedAccount;
  //List<String>? hobby;
  //List<String>? interest;
  //List<String> profilePhoto;


  RecommendProfileModel(
      {required this.profileId,
        required this.gender,
        required this.nickname,
        required this.birthday,
        required this.locationInfo,
        required this.gpsLocationInfo,
        this.mbti,
        this.intro});

  RecommendProfileModel.fromJsom(Map<String, dynamic> json) :
        //userId = json['userId'],
        profileId = json['profileId'],
        gender = json['gender'],
        nickname = json['nickname'],
        birthday = json['birthday'],
        locationInfo = json['locationInfo'],
        gpsLocationInfo = json['gpsLocationInfo'],
        mbti = json['mbti'],
        intro = json['intro'];
        // ToDo : List로 들어오는건 어떻게 넣어주어야 할지?
        //authenticatedAccount = json['authenticatedAccount'
        //hobby = jsonDecode(json['hobby']) ,
        //interest = json['interest'],
        //profilePhoto = json['profilePhoto'];
}