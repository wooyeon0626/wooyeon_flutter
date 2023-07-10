class Profile {
  String userId;
  String phone;
  String gender;
  String nickname;
  List<String> profilePhoto;
  String birthday;
  String email;
  String locationInfo;
  String? mbti;
  String? intro;
  List<String>? hobby;
  List<String>? interest;

  Profile(
      {required this.userId,
      required this.phone,
      required this.gender,
      required this.nickname,
      required this.profilePhoto,
      required this.birthday,
      required this.email,
      required this.locationInfo,
      this.mbti,
      this.intro,
      this.hobby,
      this.interest});
}
