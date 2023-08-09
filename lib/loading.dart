import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/palette.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

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
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/image/logo_transparent.png",
                fit: BoxFit.cover,
                width: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }

}