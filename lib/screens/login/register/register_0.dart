import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart' as pin;

import '../../../config/palette.dart';

class Register0 extends StatelessWidget {
  const Register0({super.key});

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
                  "코드를\n입력해주세요",
                  style: TextStyle(
                    color: Palette.black,
                    fontSize: 44,
                    letterSpacing: -2.5,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                pin.PinInputTextField(
                  pinLength: 6,
                  decoration: pin.UnderlineDecoration(
                    colorBuilder: pin.PinListenColorBuilder(
                        Palette.primary, Palette.lightGrey),
                  ),
                  controller: textFieldController,
                  autoFocus: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+$');
                    if (value.isNotEmpty && !regExp.hasMatch(value)) {
                      textFieldController.text = textFieldController.text.substring(0, textFieldController.text.length - 1);
                    }
                  },
                  cursor: pin.Cursor(
                      width: 2,
                      height: 30,
                      color: Palette.primary,
                      radius: const Radius.circular(1),
                      enabled: true,
                      orientation: pin.Orientation.vertical),
                  onSubmit: (pin) {
                    debugPrint('submit pin:$pin');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
