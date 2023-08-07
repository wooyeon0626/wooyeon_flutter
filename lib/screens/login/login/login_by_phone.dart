import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:wooyeon_flutter/config/config.dart';
import 'package:wooyeon_flutter/screens/login/login/phone_code_input.dart';
import 'package:wooyeon_flutter/screens/login/login/privacy_policy.dart';
import 'package:wooyeon_flutter/service/login/phone_auth.dart';
import 'package:wooyeon_flutter/widgets/basic_textfield.dart';
import 'package:wooyeon_flutter/widgets/next_button.dart';

import '../../../config/palette.dart';
import '../../../utils/transition.dart';

class LoginByPhone extends StatefulWidget {
  const LoginByPhone({super.key});

  @override
  State<LoginByPhone> createState() => _LoginByPhoneState();
}

class _LoginByPhoneState extends State<LoginByPhone> {
  final buttonActive = ValueNotifier<bool>(false);
  final phone = ValueNotifier<String>("");
  String? _phoneNum;

  final RegExp phoneValidator = RegExp(
    r'^01(?:0|1|[6-9])\d{8}$',
  );

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _phoneNum = (await MobileNumber.mobileNumber)!;
    } on PlatformException catch (e) {
      log("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();
    if (_phoneNum != null) {
      textFieldController.text = _phoneNum!.substring(2);
      phone.value = textFieldController.text;
      buttonActive.value = phoneValidator.hasMatch(textFieldController.text);
    }

    textFieldController.addListener(() {
      phone.value = textFieldController.text;
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
                      "전화번호를\n입력해주세요",
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
                      hintText: "전화번호를 입력해주세요.",
                      controller: textFieldController,
                      inputType: TextInputType.phone,
                      autoFocus: true,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "하이픈(-)을 제외한 숫자만 입력해주세요!",
                        style: TextStyle(
                          color: Palette.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(children: <TextSpan>[
                        const TextSpan(
                          text: '다음 버튼을 누르면 ',
                          style: TextStyle(
                            color: Palette.grey,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                            text: '개인정보처리방침',
                            style: const TextStyle(
                              color: Palette.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PrivacyPolicy()));
                              }),
                        const TextSpan(
                          text: '에 동의하는 것으로 간주합니다.',
                          style: TextStyle(
                            color: Palette.grey,
                            fontSize: 16,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: ValueListenableBuilder<String>(
                          valueListenable: phone,
                          builder: (context, phoneValue, child) {
                            //todo : 여기서 백엔드에 전화번호 전송

                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: Builder(
                                  builder: (newContext) {
                                    // 새로운 context를 변수에 저장
                                    final ctx = newContext;

                                    return NextButton(
                                      text: "다음",
                                      isActive: buttonActive,
                                      func: () async {
                                        await PhoneAuth()
                                            .sendPhoneNumberRequest(
                                            phone: phoneValue);

                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          navigateHorizontally(
                                            context: ctx,
                                            widget: PhoneCodeInput(
                                                phone: phoneValue),
                                          );
                                        });
                                      },
                                    );
                                  },
                                ));
                          }),
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
