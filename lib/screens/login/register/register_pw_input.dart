import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/login/register/register_code_input.dart';
import 'package:wooyeon_flutter/widgets/basic_textfield.dart';
import 'package:wooyeon_flutter/widgets/next_button.dart';

import '../../../config/palette.dart';

class RegisterPWInput extends StatelessWidget {
  final String email;

  const RegisterPWInput({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "비밀번호를\n설정해주세요",
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
                  hintText: "비밀번호를 입력해주세요.",
                  controller: textFieldController,
                  inputType: TextInputType.visiblePassword,
                  autoFocus: true,
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}