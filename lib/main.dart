import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uni_links/uni_links.dart';
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
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  bool? _isEmailAuth;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initUniLinks();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _initUniLinksForeground();
    }
  }

  _initUniLinks() async {
    final initialLink = await getInitialLink();

    log('[State] initialLink : $initialLink');

    if (initialLink != null) {
      _handleIncomingLink(initialLink);
    }
  }

  _initUniLinksForeground() async {
    final initialLink = await getInitialLink();

    log('[State] initialLink : $initialLink');

    if (initialLink != null) {
      _handleIncomingLinkForeground(initialLink);
    }
  }

  void _verifyTokenWithBackend(String token) async {
    // TODO: 백엔드와 통신하여 토큰 검증
    final String? email = await Pref.instance.get('email_address');

    if(email == null) {
      return;
    } else {
      bool isTokenValid = await EmailAuth().sendEmailVerifyRequest(email: email, token: token);

      setState(() {
        _isEmailAuth = isTokenValid;
        _isLoading = false;
      });
    }
  }

  Future<bool> _verifyTokenWithBackendForeground(String token) async {
    // TODO: 백엔드와 통신하여 토큰 검증
    final String? email = await Pref.instance.get('email_address');

    if(email == null) {
      return false;
    } else {
      bool isTokenValid = await EmailAuth().sendEmailVerifyRequest(email: email, token: token);

      if (isTokenValid) {
        return true;
      } else {
        return false;
      }
    }
  }


  void _handleIncomingLink(String link) {
    final uri = Uri.parse(link);

    log('[State] uri : ${uri.host}');

    if (uri.host == 'email_auth') {
      final token = uri.queryParameters['token'];

      log('[State] token : $token');

      if (token != null) {
        _verifyTokenWithBackend(token);
      }
    }
  }

  void _handleIncomingLinkForeground(String link) {
    final uri = Uri.parse(link);

    log('[State] uri : ${uri.host}');

    if (uri.host == 'email_auth') {
      final token = uri.queryParameters['token'];

      log('[State] token : $token');

      if (token != null) {
        _verifyTokenWithBackendForeground(token).then((value) {
          if(value) {
            Get.to(RegisterSuccess());
          } else {
            Get.to(RegisterEmailInput());
          }
        });
      }
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
      home: _isEmailAuth != null ? (_isEmailAuth! ? RegisterSuccess() : RegisterEmailInput()) : FutureBuilder<bool>(
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
