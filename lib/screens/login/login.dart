import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/login/login_by_phone.dart';
import 'package:wooyeon_flutter/screens/login/register_profile/rp_name.dart';
import 'package:wooyeon_flutter/widgets/login/login_is_not_working.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const LoginIsNotWorking();
      },
    );
  }

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
      if(!(await key.isGranted)) {
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
              padding: const EdgeInsets.only(left: 80, right: 80, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginInput()));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset('assets/image/google.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginInput()));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset('assets/image/kakao.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginInput()));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset('assets/image/naver.png'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  //todo: access token이 있는지 없는지 체크??
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RPName()/*const LoginByPhone()*/));
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
                        EvaIcons.phoneOutline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '전화번호로 로그인',
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
                  _showModal(context);
                },
                child: const Text(
                  "로그인이 안되나요?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
