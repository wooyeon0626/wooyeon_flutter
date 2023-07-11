import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/config/palette.dart';
import 'package:wooyeon_flutter/screens/login/login_input.dart';
import 'package:wooyeon_flutter/widgets/login/login_is_not_working.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginInput()));
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
