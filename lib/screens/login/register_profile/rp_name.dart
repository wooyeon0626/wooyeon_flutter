import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_gender.dart';
import 'package:wooyeon_flutter/widgets/login/profile_progressbar.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';
import '../../../widgets/basic_textfield.dart';

class RPName extends StatefulWidget {
  const RPName({super.key});

  @override
  State<RPName> createState() => _RPNameState();
}

class _RPNameState extends State<RPName> {
  final buttonActive = ValueNotifier<bool>(false);
  final nickname = ValueNotifier<String>("");
  String? _nickname;

  final RegExp nicknameValidator = RegExp(
    r'^[ㄱ-힣a-zA-Z\d_ -]+$',
  );

  @override
  void initState() {
    super.initState();
    _nickname = Pref.instance.profileData?.nickname;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    if (_nickname != null) {
      textFieldController.text = _nickname!;
      nickname.value = textFieldController.text;
      buttonActive.value = nicknameValidator.hasMatch(textFieldController.text);
    }

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
              const ProfileProgressBar(
                start: 0,
                end: 0.125,
              ),
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
                    letterSpacing: -2.5,
                  ),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: nickname,
                        builder: (context, nicknameValue, child) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Builder(
                              builder: (newContext) {
                                final ctx = newContext;

                                return NextButtonAsync(
                                    text: "다음",
                                    isActive: buttonActive,
                                    func: () async {
                                      Pref.instance.profileData?.nickname = nicknameValue;
                                      log(Pref.instance.profileData.toString());
                                      await Pref.instance.saveProfile();

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        navigateHorizontally(
                                          context: ctx,
                                          widget: const RPGender(),
                                        );
                                      });
                                    });
                              },
                            ),
                          );
                        }),
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
