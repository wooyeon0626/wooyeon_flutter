import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:wooyeon_flutter/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/pref.dart';

class EmailAuth extends GetxController{
  late final Rx<Stream<String>> _stream;

  EmailAuth() {
    _stream = emailVerifyRequestAndConnect().obs;
  }

  Stream<String> get stream {
    return _stream.value;
  }

  Stream<String> emailVerifyRequestAndConnect() async* {
    const url = '${Config.domain}/auth/email';

    final String? email = await Pref.instance.get('email_address');
    await Pref.instance.save('emailVerify', 'true');

    log("\n\n[EMAIL] $email");
    log("[EMAIL VERIFY STATE SET]");

    if (email == null) return;

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': '*/*',
      // 'Accept': 'text/event-stream',
    };
    String jsonBody = '{"email": "$email"}';

    final client = http.Client();
    final request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = jsonBody;
    final response = await client.send(request);

    yield* response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .where((line) => line.startsWith('data:'))
        .map((line) => line.substring(5));
  }

  Future<void> resendRequest() async {
    log("[RESEND REQUEST START]");
    _stream.value = emailVerifyRequestAndConnect();
    log("[RESEND REQUEST END]");
  }
}
