
import 'dart:developer';

import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wooyeon_flutter/models/pref.dart';
import 'package:wooyeon_flutter/screens/login/register/register_email_input.dart';
import 'package:wooyeon_flutter/screens/login/register/register_success.dart';
import 'package:wooyeon_flutter/service/login/register/email_auth.dart';

initUniLinksForeground() async {
  final initialLink = await getInitialLink();

  log('[State] initialLink : $initialLink');

  if (initialLink != null) {
    _handleIncomingLinkForeground(initialLink);
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