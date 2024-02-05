import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/login/login/login_by_email.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_name.dart';
import '../../../config/palette.dart';
import '../../../widgets/next_button.dart';
import '../login.dart';

class RegisterSuccess extends StatelessWidget {
  RegisterSuccess({super.key});

  final buttonActive = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            EvaIcons.arrowIosBack,
            color: Palette.black,
          ),
          iconSize: 40,
        ),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,

          statusBarIconBrightness: Brightness.dark, // 안드로이드용 (어두운 아이콘)
          statusBarBrightness: Brightness.light, // iOS용 (어두운 아이콘)
        ),
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/image/wooyeon_text.png",
                      fit: BoxFit.cover,
                      width: 80,
                    ),
                    const Text(
                      "에 오신",
                      style: TextStyle(
                        color: Palette.black,
                        fontSize: 32,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "것을 환영해요!",
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 32,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "성공적으로 계정이 생성되었어요.\n로그인 화면에서 로그인을 해주세요!",
                    style: TextStyle(
                      color: Palette.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: NextButton(
                func: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginByEmail()),
                    (Route<dynamic> route) => route.isFirst,
                  );
                },
                text: "로그인 화면으로",
                isActive: buttonActive),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
