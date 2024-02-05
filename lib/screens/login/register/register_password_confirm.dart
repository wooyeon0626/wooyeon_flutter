import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooyeon_flutter/screens/login/register/register_success.dart';
import 'package:wooyeon_flutter/widgets/next_button_async.dart';

import '../../../config/palette.dart';
import '../../../service/login/register/password_auth.dart';
import '../../../utils/transition.dart';
import '../../../widgets/basic_textfield.dart';
import '../../../widgets/next_button.dart';

class RegisterPasswordConfirm extends StatefulWidget {
  final String password;
  const RegisterPasswordConfirm({super.key, required this.password});

  @override
  State<RegisterPasswordConfirm> createState() => _RegisterPasswordConfirmState();
}

class _RegisterPasswordConfirmState extends State<RegisterPasswordConfirm> {
  final buttonActive = ValueNotifier<bool>(false);
  final password = ValueNotifier<String>("");

  TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textFieldController.addListener(() {
      password.value = textFieldController.text;
      buttonActive.value = (widget.password == textFieldController.text);
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
                      "비밀번호를\n재입력해주세요",
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
                      hintText: "비밀번호를 다시 입력해주세요.",
                      controller: textFieldController,
                      inputType: TextInputType.visiblePassword,
                      autoFocus: true,
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
                          //todo : 여기서 백엔드에 비밀번호 전송
                          final ctx = context;

                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              child: NextButtonAsync(
                                text: "다음",
                                isActive: buttonActive,
                                func: () async {
                                  final passwordAuth = PasswordAuth();
                                  await passwordAuth.sendPassword(passwordValue);

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    navigateHorizontally(
                                      context: ctx,
                                      widget: RegisterSuccess(),
                                    );
                                  });
                                },
                              ));
                        }),
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