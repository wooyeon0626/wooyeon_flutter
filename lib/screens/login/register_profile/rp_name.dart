import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_gender.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';

import '../../../config/palette.dart';
import '../../../widgets/basic_textfield.dart';
import '../../../widgets/next_button.dart';

class RPName extends StatelessWidget {
  RPName({super.key});

  final buttonActive = ValueNotifier<bool>(false);
  final nickname = ValueNotifier<String>("");

  final RegExp nicknameValidator = RegExp(
    r'^[ㄱ-힣a-zA-Z\d_ -]+$',
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    textFieldController.addListener(() {
      nickname.value = textFieldController.text;
      buttonActive.value = nicknameValidator.hasMatch(textFieldController.text);
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileProgressBar(start: 0, end: 0.125,),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 25, bottom: 25),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    EvaIcons.arrowIosBack,
                    color: Palette.black,
                  ),
                  iconSize: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "당신을 알아가는 시간을 가져볼게요.",
                  style: TextStyle(
                      color: Palette.primary,
                      fontSize: 18,
                      letterSpacing: -2.5,),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "이름이 무엇인가요?",
                  style: TextStyle(
                      color: Palette.black,
                      fontSize: 32,
                      letterSpacing: -2.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: BasicTextField(
                  hintText: "이름을 입력하세요",
                  controller: textFieldController,
                  inputType: TextInputType.emailAddress,
                  autoFocus: true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 40, right: 40),
                child: Text(
                  "프로필에 표시되는 이름이에요. 한글/영어/숫자/밑줄/띄어쓰기를 사용할 수 있어요.",
                  style: TextStyle(
                    color: Palette.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: nickname,
                        builder: (context, nicknameValue, child) {
                          // todo: 여기서 pref에 저장하기

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: NextButton(
                                nextPage: RPGender(),
                                text: "다음",
                                isActive: buttonActive),
                          );
                        }
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}