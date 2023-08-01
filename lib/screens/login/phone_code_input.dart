import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart' as pin;
import 'package:wooyeon_flutter/screens/login/register/register_pw_input.dart';

import '../../../config/palette.dart';
import '../../../widgets/next_button.dart';

class PhoneCodeInput extends StatelessWidget {
  final String phone;
  final String code = "abc123"; //todo : 코드 문자에서 자동 긁어오기 또는 입력 -> sms_autofill 패키지 활용하기

  PhoneCodeInput({required this.phone, super.key});

  final buttonActive = ValueNotifier<bool>(false);
  final inputCode = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    const codeLength = 6;
    TextEditingController textFieldController = TextEditingController();

    textFieldController.addListener(() {
      inputCode.value = textFieldController.text;
      buttonActive.value = textFieldController.text.length == codeLength;
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
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
                  "코드를\n입력해주세요",
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 44,
                    letterSpacing: -2.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 20),
                  child: Text(
                    phone,
                    style: const TextStyle(
                      color: Palette.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                pin.PinInputTextField(
                  pinLength: codeLength,
                  decoration: pin.UnderlineDecoration(
                    colorBuilder: pin.PinListenColorBuilder(
                        Palette.primary, Palette.lightGrey),
                  ),
                  controller: textFieldController,
                  autoFocus: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    RegExp regExp = RegExp(r'^[a-zA-Z\d]+$');
                    if (value.isNotEmpty && !regExp.hasMatch(value)) {
                      textFieldController.text = textFieldController.text
                          .substring(0, textFieldController.text.length - 1);
                    }
                  },
                  cursor: pin.Cursor(
                      width: 2,
                      height: 30,
                      color: Palette.primary,
                      radius: const Radius.circular(1),
                      enabled: true,
                      orientation: pin.Orientation.vertical),
                  onSubmit: (pin) {
                    debugPrint('submit pin:$pin');
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "입력한 이메일 주소로 본인 인증을 위한 코드를 보내드렸어요.",
                    style: TextStyle(
                      color: Palette.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "혹시 메일이 오지 않았나요?",
                      style: TextStyle(
                        color: Palette.grey,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "코드 재전송",
                        style: TextStyle(
                          color: Palette.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ValueListenableBuilder<String>(
                  valueListenable: inputCode,
                  builder: (context, codeValue, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: NextButton(
                        text: "다음",
                        isActive: buttonActive,
                        func: () {
                          if (codeValue == code) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                    RegisterPWInput(email: phone),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = const Offset(1.0, 0.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          } else {
                            textFieldController.text = "";
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Palette.red,
                                content: Center(
                                  child: Text(
                                    '틀린 코드입니다!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
