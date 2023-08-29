class Profile {
  String? nickname;
  String? gender;
  String? birthday;
  String? mbti;
  String? intro;
  List<String>? hobby;
  List<String>? interest;
  List<String>? profilePhoto;
  String? locationInfo;
  bool? faceAuthentication;

  Profile({
    this.nickname,
    this.gender,
    this.birthday,
    this.mbti,
    this.intro,
    this.hobby,
    this.interest,
    this.profilePhoto,
    this.locationInfo,
    this.faceAuthentication,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      nickname: json['nickname'] ?? '',
      gender: json['gender'] ?? '',
      birthday: json['birthday'] ?? '',
      mbti: json['mbti'] ?? '',
      intro: json['intro'] ?? '',
      hobby: json['hobby'] != null ? List<String>.from(json['hobby']) : null,
      interest:
          json['interest'] != null ? List<String>.from(json['interest']) : null,
      profilePhoto: json['profilePhoto'] != null ? List<String>.from(json['profilePhoto']) : null,
      locationInfo: json['locationInfo'] ?? '',
      faceAuthentication: json['faceAuthentication'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'gender': gender,
      'birthday': birthday,
      'mbti': mbti,
      'intro': intro,
      'hobby': hobby,
      'interest': interest,
      'profilePhoto': profilePhoto,
      'locationInfo': locationInfo,
      'faceAuthentication': faceAuthentication,
    };
  }
}
