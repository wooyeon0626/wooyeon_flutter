import 'dart:convert';
import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wooyeon_flutter/screens/login/register/register_password_confirm.dart';

import '../../../config/palette.dart';
import '../../../models/pref.dart';
import '../../../service/login/register/email_auth.dart';
import '../../../widgets/basic_textfield.dart';
import '../../../widgets/next_button.dart';

class RegisterCodeWaiting extends StatefulWidget {
  final String email;

  const RegisterCodeWaiting({super.key, required this.email});

  @override
  State<RegisterCodeWaiting> createState() => _RegisterCodeWaitingState();
}

class _RegisterCodeWaitingState extends State<RegisterCodeWaiting> {
  final EmailAuth emailAuth = Get.find();

  @override
  void initState() {
    super.initState();
    emailAuth.resendRequest();
  }

  @override
  Widget build(BuildContext context) {
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

      /// StreamBuilder로 SSE String Stream 감지
      body: Obx(
        () => StreamBuilder<String>(
          stream: emailAuth.stream,
          builder: (context, snapshot) {
            log("\n\n\n======= Stream Text ======");
            log("connectionState : ${snapshot.connectionState}");
            log("hasData : ${snapshot.hasData}");
            log("data : ${snapshot.data}");
            log("============================\n\n\n");

            if (snapshot.connectionState == ConnectionState.waiting) {
              return _EmailAuthWaiting(widget.email);
            }

            if (snapshot.hasError) {
              log("[EMAIL AUTH ERROR]\n\t: ${snapshot.error}");
            }

            if (snapshot.hasData) {
              // JSON 문자열을 Dart 객체로 변환
              var data = json.decode(snapshot.data!);

              if (data['statusName'] != null &&
                  data['statusName'] == 'success') {
                /// SSE 연결 성공
                log("[EMAIL AUTH] SSE 연결 성공");
                return _EmailAuthWaiting(widget.email);
              } else if (data['statusName'] != null &&
                  data['statusName'] == 'duplicated') {
                /// SSE 연결 성공
                log("[EMAIL AUTH] SSE 이메일 중복");
                return _EmailAuthWaiting(widget.email);
              } else if (data['statusName'] != null &&
                  data['statusName'] == 'completed') {
                /// SSE 연결 성공
                log("[EMAIL AUTH] SSE 이메일 인증 이미 성공");
                Pref.instance.delete('emailVerify');
                return _EmailAuthSuccess();
              } else if (data['statusName'] != null &&
                  data['statusName'] == 'ExistsUser') {
                /// 회원 존재
                log("[EMAIL AUTH] 회원");
                Pref.instance.delete('emailVerify');
                return _EmailAuthUserExists(widget.email);
              } else if (data['emailAuth'] != null &&
                  data['emailAuth'] == 'success') {
                /// 이메일 인증 성공
                Pref.instance.delete('emailVerify');
                log("[EMAIL AUTH] 이메일 인증 성공, 비밀번호 입력 필요.");
                return _EmailAuthSuccess();
              } else {
                /// 이메일 인증 진행 중
                log("[EMAIL AUTH] 이메일 인증 진행 중");
                return _EmailAuthWaiting(widget.email);
              }
            } else {
              return const Center(child: Text('데이터가 없습니다.'));
            }
          },
        ),
      ),
    );
  }
}

class _EmailAuthUserExists extends StatelessWidget {
  final String email;

  const _EmailAuthUserExists(this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "이미 가입된\n이메일입니다!",
              style: TextStyle(
                color: Palette.black,
                fontSize: 32,
                letterSpacing: -1,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                email,
                style: const TextStyle(
                  color: Palette.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "이미 가입된 이메일이에요. 혹시 비밀번호를 잊으셨나요?",
                style: TextStyle(
                  color: Palette.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailAuthWaiting extends StatelessWidget {
  final String email;

  const _EmailAuthWaiting(this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "이메일을\n확인해주세요!",
              style: TextStyle(
                color: Palette.black,
                fontSize: 32,
                letterSpacing: -1,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: Text(
                email,
                style: const TextStyle(
                  color: Palette.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                "인증 메일을 보내드렸어요.\n인증 메일 내 버튼을 눌러 이메일 인증을 완료해주세요.",
                style: TextStyle(
                  color: Palette.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailAuthSuccess extends StatefulWidget {
  @override
  State<_EmailAuthSuccess> createState() => _EmailAuthSuccessState();
}

class _EmailAuthSuccessState extends State<_EmailAuthSuccess> {
  final buttonActive = ValueNotifier<bool>(false);
  final password = ValueNotifier<String>("");

  final RegExp passwordValidator = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[^A-Za-z\d])[A-Za-z\d\S]{8,}$',
  );

  TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Pref.instance.delete('emailVerify');
    log("[EMAIL VERIFY STATE REMOVE]");

    textFieldController.addListener(() {
      password.value = textFieldController.text;
      buttonActive.value = passwordValidator.hasMatch(textFieldController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    "비밀번호를\n입력해주세요",
                    style: TextStyle(
                      color: Palette.black,
                      fontSize: 32,
                      letterSpacing: -1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BasicTextField(
                    hintText: "비밀번호를 입력해주세요.",
                    controller: textFieldController,
                    inputType: TextInputType.visiblePassword,
                    autoFocus: true,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "비밀번호는 알파벳, 숫자가 포함된 8자 이상의 길이로 구성되어야 합니다.",
                      style: TextStyle(
                        color: Palette.grey,
                        fontSize: 12,
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
                      valueListenable: password,
                      builder: (context, passwordValue, child) {
                        //todo : 여기서 백엔드에 이메일 전송

                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: NextButton(
                              text: "다음",
                              isActive: buttonActive,
                              nextPage: RegisterPasswordConfirm(
                                password: passwordValue,
                              ),
                            ));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
