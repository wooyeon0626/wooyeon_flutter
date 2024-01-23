import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/login.dart';
import 'package:wooyeon_flutter/screens/login/register/register_email_input.dart';
import 'package:wooyeon_flutter/screens/login/register/register_success.dart';
import 'package:wooyeon_flutter/service/login/auto_login/auth.dart';
import 'package:wooyeon_flutter/service/login/register/email_auth.dart';

import 'loading.dart';
import 'models/controller/chat_controller.dart';
import 'screens/main_screen.dart';
import 'config/palette.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final EmailAuth sseClient = Get.put(EmailAuth());
  initializeDateFormatting('ko_KR', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  final Auth _auth = Auth();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    final String? emailVerify = await Pref.instance.get('emailVerify');

    log("[STATE] $state, [EMAIL] $emailVerify");

    if(state == AppLifecycleState.resumed && emailVerify != null) {
      final EmailAuth emailAuth = Get.find();
      emailAuth.resendRequest();
    }
  }

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
