import 'dart:convert';
import 'dart:developer';

import 'package:wooyeon_flutter/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/pref.dart';

class EmailAuth {
  Stream<String>? _stream;

  Stream<String> get stream {
    _stream ??= emailVerifyRequestAndConnect();
    return _stream!;
  }

  // /// send email address to server.
  // Future<bool> sendEmailRequest({required String email}) async {
  //   const url = '${Config.domain}/auth/email';
  //
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': email,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
  //     return true;
  //   } else {
  //     log("Error with status code : ${response.statusCode}");
  //     return false;
  //   }
  // }
  //
  // /// send email address and authentication token to server.
  // Future<bool> sendEmailVerifyRequest(
  //     {required String email, required String token}) async {
  //   const url = '${Config.domain}/auth/email/verify';
  //
  //   String phone = (await Pref.instance.get('phone_number'))!;
  //
  //   log("[PHONE] $phone");
  //   log("[EMAIL] $email");
  //   log("[TOKEN] $token");
  //
  //
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'phone': phone,
  //       'email': email,
  //       'authToken': token,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
  //     Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  //
  //     final String emailAuth = decodedResponse['emailAuth'];
  //
  //     if (emailAuth == 'success') {
  //       return true;
  //     } else if (emailAuth == 'fail') {
  //       return false;
  //     } else {
  //       log("An error occurred during email verification process");
  //       return false;
  //     }
  //   } else {
  //     log("Error with status code : ${response.statusCode}");
  //     return false;
  //   }
  // }

  //TODO 구현 필요.
  Stream<String> emailVerifyRequestAndConnect() async* {
    const url = '${Config.domain}/auth/email';

    final String? email = await Pref.instance.get('email_address');

    log("\n\n[EMAIL] $email");

    if (email == null) return;

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'text/event-stream',
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
}
