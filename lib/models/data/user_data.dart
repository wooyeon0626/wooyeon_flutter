class Profile {
  String? nickname;
  String? gender;
  String? birthday;
  String? mbti;
  String? intro;
  List<String>? hobby;
  List<String>? interest;
  String? gpsLocationInfo;

  Profile({
    this.nickname,
    this.gender,
    this.birthday,
    this.mbti,
    this.intro,
    this.hobby,
    this.interest,
    this.gpsLocationInfo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      nickname: json['nickname'] ?? '',
      gender: json['gender'] ?? 'M',
      birthday: json['birthday'] ?? '',
      mbti: json['mbti'] ?? '',
      intro: json['intro'] ?? '',
      hobby:
          json['hobby'] != null ? (json['hobby'] as String).split(',') : null,
      interest: json['interest'] != null
          ? (json['interest'] as String).split(',')
          : null,
      gpsLocationInfo: json['gpsLocationInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'gender': gender ?? "M",
      'birthday': birthday,
      'mbti': mbti,
      'intro': intro,
      'hobby':hobby?.join(','),
      'interest': interest?.join(','),
      "gpsLocationInfo": gpsLocationInfo,
    };
  }
}
