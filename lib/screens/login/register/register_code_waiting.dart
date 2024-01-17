import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/palette.dart';
import '../../../models/pref.dart';
import '../../../service/login/register/email_auth.dart';
import '../../../widgets/basic_textfield.dart';
import '../../../widgets/next_button.dart';

class RegisterCodeWaiting extends StatefulWidget {
  final String email;

  const RegisterCodeWaiting({required this.email, super.key});

  @override
  State<RegisterCodeWaiting> createState() => _RegisterCodeWaitingState();
}

class _RegisterCodeWaitingState extends State<RegisterCodeWaiting> {
   final EmailAuth sseClient = EmailAuth();

  final buttonActive = ValueNotifier<bool>(true);
  final password = ValueNotifier<String>("");

  final RegExp passwordValidator = RegExp(
    //TODO: 정규표현식 수정 필요
    r'^[a-zA-Z\d._%+-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$',
  );

  TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textFieldController.addListener(() {
      password.value = textFieldController.text;
      buttonActive.value = false;

      ///passwordValidator.hasMatch(textFieldController.text);
    });
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
      body: StreamBuilder<String>(
        stream: sseClient.stream,
        builder: (context, snapshot) {

          log("\n\n\n======= Stream Text ======");
          log("connectionState : ${snapshot.connectionState}");
          log("hasData : ${snapshot.hasData}");
          log("data : ${snapshot.data}");
          log("============================\n\n\n");

          if (snapshot.connectionState == ConnectionState.active) {
            /// 서버로부터 Data 수신
            /// 받은 데이터 중, 이메일 인증 완료 메시지를 받았을 때에만 데이터 리턴되어야 함.
            /// 추가 필요..

            log("\n\n=== STREAM BUILDER STATE ===");
            log("hasData : ${snapshot.hasData}");
            log("data : ${snapshot.data}");
            log("============================\n\n");

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
                              "비밀번호 입력 추가 메시지",
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: NextButton(
                                      text: "다음",
                                      isActive: buttonActive,
                                      nextPage: RegisterCodeWaiting(
                                          email: passwordValue),
                                    ));
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            /// 서버 응답 대기중
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
                        widget.email,
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
          } else {
            /// 수신 종료
            return const Center(child: Text('수신이 종료되었습니다'));
          }
        },
      ),
    );
  }
}
