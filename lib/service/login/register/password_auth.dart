import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:wooyeon_flutter/service/encrypt/encrypt_service.dart';
import 'dart:math' hide log;
import '../../../config/config.dart';
import '../../../models/pref.dart';

class PasswordAuth {
  Future<bool> sendPassword(String password) async {
    const getEncryptKey = '${Config.domain}/encrypt/key';
    const sendCiphertext = '${Config.domain}/encrypt/pw';

    /// Session Key & IV 랜덤 생성
    final keyBytes = Uint8List.fromList(
        List<int>.generate(16, (i) => Random.secure().nextInt(256)));
    final iv = Uint8List.fromList(
        List<int>.generate(16, (i) => Random.secure().nextInt(256)));

    log('keyBytes : $keyBytes');
    log('iv : $iv');

    /// Password Base64 Encoding
    List<int> passwordBytes = utf8.encode(password); // 텍스트를 바이트로 변환
    String passwordBase64 = base64.encode(passwordBytes); // 바이트를 Base64로 인코딩

    log('PasswordBase64 : $passwordBase64');

    /// Password Encrypt
    Uint8List ciphertextInt = AesEncryptionService()
        .encrypt(keyBytes: keyBytes, iv: iv, plaintext: passwordBase64);

    String ciphertext = base64Encode(ciphertextInt);
    log('CypherText : $ciphertext');

    /// 공개 키 가져오기
    final getEncryptKeyResponse = await http.get(
      Uri.parse(getEncryptKey),
    );

    late final String encryptKey;

    if (getEncryptKeyResponse.statusCode == 200 ||
        getEncryptKeyResponse.statusCode == 201 ||
        getEncryptKeyResponse.statusCode == 202 ||
        getEncryptKeyResponse.statusCode == 204) {
      Map<String, dynamic> decodedEncryptKey = jsonDecode(getEncryptKeyResponse.body);
      encryptKey = decodedEncryptKey['publicKey'];
    } else {
      log("Error with status code : ${getEncryptKeyResponse.statusCode}");
    }

    log('encryptKey : $encryptKey');

    /// 공개 키로 세션키 암호화
    String sessionKey = base64Encode(keyBytes);
    String ivString = base64Encode(iv);

    Uint8List publicKeyBytes = base64Decode(encryptKey);
    log('publicKeyBytes : $publicKeyBytes');
    String cipherSessionKey = base64Encode(RsaEncryptionService().encrypt(sessionKey, publicKeyBytes));

    log('cipherSessionKey : $cipherSessionKey');

    /// ciphertext & cipherkey 전송
    final String? email = await Pref.instance.get('email_address');

    if (email == null) {
      log('[ERROR] email is null');
      return false;
    }

    log('[IV + cipherSessionKey] $ivString|$cipherSessionKey');

    final response = await http.post(Uri.parse(sendCiphertext), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'email': email,
        'encryptedPassword' : ciphertext,
        'encryptedKey' : '$ivString|$cipherSessionKey'
      }),
    );

    if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
      log("[SUCCESS] success to send ciphertext");
      return true;
    } else {
      log("Error with status code : ${response.statusCode}");
      return false;
    }
  }
}
