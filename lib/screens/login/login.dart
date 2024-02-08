import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/login/login_by_email.dart';
import 'package:wooyeon_flutter/screens/login/register/register_email_input.dart';
import 'package:wooyeon_flutter/screens/login/register/register_password_confirm.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_name.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> _profileDataLoad() async {
    await Pref.instance.loadProfile();
    log("Profile loaded.");
  }

  @override
  void initState() {
    super.initState();
    permission();
    _profileDataLoad();
  }

  Future<bool> permission() async {
    Map<Permission, PermissionStatus> status =
        await [Permission.location, Permission.phone].request();

    bool flag = true;
    status.forEach((key, value) async {
      if (!(await key.isGranted)) {
        flag = false;
      }
      log('[Permission Status] $key : $value');
    });

    return Future(() => flag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Palette.primary,
          statusBarIconBrightness: Brightness.light, // 안드로이드용 (밝은 아이콘)
          statusBarBrightness: Brightness.dark, // iOS용 (밝은 아이콘)
        ),
        backgroundColor: Palette.primary,
        elevation: 0,
      ),
      body: Container(
        color: Palette.primary,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/image/logo_transparent.png",
                  fit: BoxFit.cover,
                  width: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  //todo: access token이 있는지 없는지 체크??
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginByEmail()));
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: const Border.fromBorderSide(
                      BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.emailOutline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '이메일로 로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextButton(
                onPressed: () {
                  // TODO : REGISTER EMAIL INPUT
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegisterEmailInput()));
                },
                child: const Text(
                  "회원가입",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
