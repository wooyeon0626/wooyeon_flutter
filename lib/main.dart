import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wooyeon_flutter/screens/login/login.dart';
import 'package:wooyeon_flutter/service/auth.dart';

import 'loading.dart';
import 'models/controller/chat_controller.dart';
import 'screens/main_screen.dart';
import 'config/palette.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting('ko_KR', null).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ChatController());
      }),
      debugShowCheckedModeBanner: false,
      title: '우연',
      theme: ThemeData(
        primaryColor: Palette.primary,
        primarySwatch: ColorService.createMaterialColor(Palette.primary),
        fontFamily: 'Pretendard',
      ),
      home: FutureBuilder<bool>(
        future: _auth.autoLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const MainScreen();
            } else {
              return const Login();
            }
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}

class ColorService {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
