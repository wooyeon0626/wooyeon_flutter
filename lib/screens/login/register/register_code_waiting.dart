import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/palette.dart';
import '../../../models/pref.dart';
import '../../../service/login/register/email_auth.dart';

class RegisterCodeWaiting extends StatefulWidget {
  final String email;

  const RegisterCodeWaiting({required this.email, super.key});

  @override
  State<RegisterCodeWaiting> createState() => _RegisterCodeWaitingState();
}

class _RegisterCodeWaitingState extends State<RegisterCodeWaiting> {

  Future<void> sendEmail() async {
    await EmailAuth().sendEmailRequest(
        email: widget.email);
    await Pref.instance
        .save('email_address', widget.email);
  }

  @override
  void initState() {
    super.initState();
    sendEmail();
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
      body: Container(
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
                  fontSize: 44,
                  letterSpacing: -2.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Text(
                  widget.email,
                  style: const TextStyle(
                    color: Palette.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "인증 메일을 보내드렸어요. 인증 메일 내 버튼을 눌러 이메일 인증을 완료해주세요.",
                  style: TextStyle(
                    color: Palette.grey,
                    fontSize: 16,
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
