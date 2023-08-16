import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart' as pin;
import 'package:sms_autofill/sms_autofill.dart';
import 'package:wooyeon_flutter/screens/login/register/register_email_input.dart';
import 'package:wooyeon_flutter/service/login/phone_auth.dart';
import 'package:wooyeon_flutter/utils/notifier.dart';
import 'package:wooyeon_flutter/utils/transition.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../../config/palette.dart';
import 'login_success.dart';

class PhoneCodeInput extends StatefulWidget {
  final String phone;

  const PhoneCodeInput({required this.phone, super.key});

  @override
  State<PhoneCodeInput> createState() => _PhoneCodeInputState();
}

class _PhoneCodeInputState extends State<PhoneCodeInput> {
  final buttonActive = ValueNotifier<bool>(false);
  final inputCode = ValueNotifier<String>("");

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

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
            child: Stack(
              children: [
                Column(
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
                        widget.phone,
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
                    PinFieldAutoFill(
                      codeLength: codeLength,
                      decoration: pin.UnderlineDecoration(
                        colorBuilder: pin.PinListenColorBuilder(
                            Palette.primary, Palette.lightGrey),
                      ),
                      controller: textFieldController,
                      autoFocus: true,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      onCodeChanged: (value) {
                        if (value == null) return;
                        RegExp regExp = RegExp(r'^\d+$');
                        if (value.isNotEmpty && !regExp.hasMatch(value)) {
                          textFieldController.text = textFieldController.text
                              .substring(
                                  0, textFieldController.text.length - 1);
                        }
                      },
                      cursor: pin.Cursor(
                          width: 2,
                          height: 30,
                          color: Palette.primary,
                          radius: const Radius.circular(1),
                          enabled: true,
                          orientation: pin.Orientation.vertical),
                      onCodeSubmitted: (pin) {
                        log('submit pin : $pin');
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "문자로 본인 인증을 위한 코드를 보내드렸어요.",
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
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Center(
                                      child: Text(
                                    '코드 재전송',
                                    style: TextStyle(color: Palette.primary),
                                  )),
                                  content: const Text(
                                    '코드를 정말 재전송할까요?',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('확인'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: ValueListenableBuilder<String>(
                      valueListenable: inputCode,
                      builder: (context, codeValue, child) {
                        //todo : 1. 백엔드에 코드를 전송하여 일치하는지 확인,  2. 로그인인지 회원가입인지 상태 확인
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Builder(
                              builder: (newContext) {
                                // 새로운 context를 변수에 저장
                                final ctx = newContext;

                                return NextButtonAsync(
                                  text: "다음",
                                  isActive: buttonActive,
                                  func: () async {
                                    final dynamic phoneAuth =
                                        await PhoneAuth()
                                            .sendPhoneVerifyRequest(
                                                phone: widget.phone,
                                                code: codeValue);

                                    if (phoneAuth != false) {
                                      final bool isAuth =
                                          phoneAuth['phoneAuth'] == 'success'
                                              ? true
                                              : false; // 인증 완료 여부
                                      final bool isRegistered =
                                          phoneAuth['register'] == 'success'
                                              ? true
                                              : false; // 회원가입 정보, 백엔드에서 가져오기
                                      final bool isProfile = phoneAuth[
                                                  'profile'] ==
                                              'success'
                                          ? true
                                          : false; // 프로필을 끝까지 등록했는지 또는 아닌지, pref로 저장하기
                                      final bool isAgreement = phoneAuth[
                                                  'serviceTerms'] ==
                                              'success'
                                          ? true
                                          : false; // 이용약관에 동의했는지 또는 아닌지, pref로 저장하기

                                      if (isAuth) {
                                        // 저장된 context 사용
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          navigateHorizontally(
                                              context: ctx,
                                              widget: isRegistered
                                                  ? LoginSuccess(
                                                      /// Todo: 자동 로그인 시 해당 부분 수정 필요.
                                                      /// phone, code를 넘기지 않고 여기서 토큰 처리.
                                                      phone: widget.phone,
                                                      code: codeValue,
                                                    )
                                                  : RegisterEmailInput());
                                        });
                                      } else {
                                        textFieldController.text = "";
                                        // 저장된 context 사용
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          showCustomSnackBar(
                                              context: ctx,
                                              text: '코드가 틀렸습니다!',
                                              color: Palette.red);
                                        });
                                      }
                                    } else {
                                      textFieldController.text = "";
                                      // 저장된 context 사용
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        showCustomSnackBar(
                                            context: ctx,
                                            text: '인증 오류가 발생했습니다!',
                                            color: Palette.red);
                                      });
                                    }
                                  },
                                );
                              },
                            ));
                      },
                    ),
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
