import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register/register_code_waiting.dart';
import 'package:wooyeon_flutter/service/login/register/email_auth.dart';
import 'package:wooyeon_flutter/widgets/basic_textfield.dart';
import 'package:wooyeon_flutter/widgets/next_button.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class RegisterEmailInput extends StatelessWidget {
  RegisterEmailInput({super.key});

  final buttonActive = ValueNotifier<bool>(false);
  final email = ValueNotifier<String>("");

  final RegExp phoneValidator = RegExp(
    r'^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    textFieldController.addListener(() {
      email.value = textFieldController.text;
      buttonActive.value = phoneValidator.hasMatch(textFieldController.text);
    });

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "이메일을\n입력해주세요",
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
                      hintText: "이메일을 입력해주세요.",
                      controller: textFieldController,
                      inputType: TextInputType.emailAddress,
                      autoFocus: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "입력한 이메일로 인증코드를 발송하므로, 꼭 확인 가능한 메일 주소를 적어주세요",
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
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: email,
                        builder: (context, emailValue, child) {
                          //todo : 여기서 백엔드에 이메일 전송

                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              child: NextButton(
                                text: "다음",
                                isActive: buttonActive,
                                nextPage: RegisterCodeWaiting(
                                    email: emailValue),
                              ));
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
