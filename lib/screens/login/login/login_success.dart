import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/main_screen.dart';

import '../../../config/palette.dart';
import '../../../widgets/next_button.dart';

class LoginSuccess extends StatelessWidget {
  LoginSuccess({super.key});

  final nickname = Pref.instance.profileData?.nickname;
  final buttonActive = ValueNotifier<bool>(true);

  // todo : 혹시 로그인 최종 과정에서 필요한 작업이 있다면 여기에서 코드 추가 작성

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            color: Palette.black,
                            fontSize: 20,
                          ),
                          children: [
                        const TextSpan(text: '근처에 '),
                        const TextSpan(
                          text: '137명',
                          style: TextStyle(
                              color: Palette.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '의 친구들이\n'),
                        TextSpan(
                          text: '$nickname',
                          style: const TextStyle(
                              color: Palette.secondary,
                              fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(text: '님을 찾고있어요!\n'),
                      ]))
                  ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: NextButton(
                          func: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MainScreen()),
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
