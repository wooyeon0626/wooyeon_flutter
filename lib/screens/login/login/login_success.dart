import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/main_screen.dart';
import 'package:wooyeon_flutter/service/login/auto_login/auth.dart';

import '../../../config/palette.dart';
import '../../../widgets/next_button.dart';

class LoginSuccess extends StatelessWidget {
  final String phone;
  final String code;

  LoginSuccess({required this.phone, required this.code, super.key});

  final buttonActive = ValueNotifier<bool>(true);

  // todo : 혹시 로그인 최종 과정에서 필요한 작업이 있다면 여기에서 코드 추가 작성

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "다시 오셨군요 :)",
                style: TextStyle(
                    color: Palette.black,
                    fontSize: 32,
                    letterSpacing: -2.5,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "근처에 xx명의 친구들이 xx님을 찾고있어요!",
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: NextButton(
                          func: () {
                            Auth().login(phone, code);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => const MainScreen()),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          text: "다음",
                          isActive: buttonActive)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
