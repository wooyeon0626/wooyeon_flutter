import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_name.dart';
import '../../../config/palette.dart';
import '../../../widgets/next_button.dart';

class RegisterSuccess extends StatelessWidget {
  RegisterSuccess({super.key});

  final buttonActive = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                      width: 110,
                    ),
                    const Text(
                      "에 오신",
                      style: TextStyle(
                        color: Palette.black,
                        fontSize: 44,
                        letterSpacing: -2.5,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "것을 환영해요!",
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 44,
                    letterSpacing: -2.5,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    "성공적으로 계정이 생성되었어요.\n이제 당신을 알아가는 시간을 가져볼게요!",
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
                        builder: (BuildContext context) => const RPName()),
                    (Route<dynamic> route) => route.isFirst,
                  );
                },
                text: "프로필 등록하기",
                isActive: buttonActive),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
