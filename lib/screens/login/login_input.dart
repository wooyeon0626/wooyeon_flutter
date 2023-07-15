import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/login/register/register_code_input.dart';
import 'package:wooyeon_flutter/widgets/basic_textfield.dart';
import 'package:wooyeon_flutter/widgets/next_button.dart';

import '../../config/palette.dart';
import 'login/login_pw_input.dart';

class LoginInput extends StatelessWidget {
  LoginInput({super.key});

  final buttonActive = ValueNotifier<bool>(false);
  final email = ValueNotifier<String>("");

  final RegExp emailValidator = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    textFieldController.addListener(() {
      email.value = textFieldController.text;
      buttonActive.value = emailValidator.hasMatch(textFieldController.text);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "이메일 주소를\n입력해주세요",
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 44,
                    letterSpacing: -2.5,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                BasicTextField(
                  hintText: "이메일 주소를 입력해주세요.",
                  controller: textFieldController,
                  inputType: TextInputType.emailAddress,
                  autoFocus: true,
                ),
                const SizedBox(
                  height: 120,
                ),
                ValueListenableBuilder<String>(
                  valueListenable: email,
                  builder: (context, emailValue, child) {
                    // todo: 백엔드와 통신 필요. 이메일 전송 -> 회원인지 아닌지 체크 -> 회원이라면 true, 아니라면 false & 해당 메일로 인증 메일 발송 & 생성된 코드도 함께 받기

                    bool isRegistered = false;
                    String? code = "abc123";

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: NextButton(nextPage: isRegistered ? LoginPWInput(email: emailValue,) : RegisterCodeInput(email: emailValue, code: code,), text: "다음", isActive: buttonActive),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}