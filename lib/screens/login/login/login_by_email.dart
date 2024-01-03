import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';
import '../../../widgets/basic_textfield.dart';
import '../../../widgets/next_button_async.dart';
import 'login_by_email_password.dart';

class LoginByEmail extends StatelessWidget {
  final buttonActive = ValueNotifier<bool>(false);
  final email = ValueNotifier<String>("");

  final RegExp emailValidator = RegExp(
    r'^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$',
  );

  LoginByEmail({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    textFieldController.addListener(() {
      email.value = textFieldController.text;
      buttonActive.value = emailValidator.hasMatch(textFieldController.text);
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
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: ValueListenableBuilder<String>(
                        valueListenable: email,
                        builder: (context, emailValue, child) {

                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              child: Builder(
                                builder: (newContext) {
                                  // 새로운 context를 변수에 저장
                                  final ctx = newContext;

                                  return NextButtonAsync(
                                    text: "다음",
                                    isActive: buttonActive,
                                    func: () async {

                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        navigateHorizontally(
                                          context: ctx,
                                          widget: LoginByEmailPassword(email: emailValue,));
                                      });
                                    },
                                  );
                                },
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