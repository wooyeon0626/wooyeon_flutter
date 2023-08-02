import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../config/palette.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "개인정보 처리 방침",
                style: TextStyle(
                    color: Palette.black,
                    fontSize: 24,
                    letterSpacing: -2.5,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "가. 어쩌구 저쩌구...",
                  style: TextStyle(
                    color: Palette.black,
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