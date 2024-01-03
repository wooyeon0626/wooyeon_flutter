import 'dart:convert';
import 'dart:developer';

import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:wooyeon_flutter/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/models/pref.dart';

class EmailAuth {
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
  Future<bool> emailVerifyRequest({required String email}) async {
    const url = '${Config.domain}/auth/email/verify';

    log("[EMAIL] $email");

    final response = SSEClient.subscribeToSSE(
        method: SSERequestType.POST,
        url: url,
        header: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: {
          'email': email,
        }).listen(
          (event) {
        log('Id: ${event.id!}');
        log('Event: ${event.event!}');
        log('Data: ${event.data!}');
      },
    );

    return false;
  }
}
