import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wooyeon_flutter/loading.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/login.dart';
import 'package:wooyeon_flutter/screens/login/register/register_email_input.dart';
import 'package:wooyeon_flutter/screens/login/register/register_success.dart';
import 'package:wooyeon_flutter/screens/main_screen.dart';
import 'package:wooyeon_flutter/service/login/auto_login/auth.dart';
import 'package:wooyeon_flutter/service/login/register/email_auth.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final Auth _auth = Auth();
  bool? _isEmailAuth;
  bool _isLoading = true;
  bool isDeepLinkHandled = false;

  _initUniLinks() async {
    final initialLink = await getInitialLink();

    log('[State] initialLink : $initialLink');

    if (initialLink != null) {
      _handleIncomingLink(initialLink);
      isDeepLinkHandled = true;
    }
  }

  void _verifyTokenWithBackend(String token) async {
    // TODO: 백엔드와 통신하여 토큰 검증
    final String? email = await Pref.instance.get('email_address');

    if (email == null) {
      return;
    } else {
      bool isTokenValid =
          await EmailAuth().sendEmailVerifyRequest(email: email, token: token);

      setState(() {
        _isEmailAuth = isTokenValid;
        _isLoading = false;
      });
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

  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return _isEmailAuth != null
        ? (_isEmailAuth! ? RegisterSuccess() : RegisterEmailInput())
        : FutureBuilder<bool>(
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
          );
  }
}
