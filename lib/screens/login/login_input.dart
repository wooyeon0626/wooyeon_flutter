import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/login/register/register_0.dart';
import 'package:wooyeon_flutter/widgets/basic_textfield.dart';
import 'package:wooyeon_flutter/widgets/next_button.dart';

import '../../config/palette.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({super.key});

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
                  "이메일 주소를\n입력해주세요",
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
                  hintText: "이메일 주소를 입력해주세요.",
                  controller: textFieldController,
                  inputType: TextInputType.emailAddress,
                  autoFocus: true,
                ),
                const SizedBox(
                  height: 120,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: NextButton(nextPage: Register0(), text: "다음"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
