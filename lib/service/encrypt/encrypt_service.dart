import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/asn1.dart';
import 'package:pointycastle/export.dart';

class AesEncryptionService {
  Uint8List encrypt({
    required Uint8List keyBytes,
    required Uint8List iv,
    required String plaintext,
  }) {
    final key = KeyParameter(keyBytes);
    final ivParam = ParametersWithIV<KeyParameter>(key, iv);
    final paddedParams = PaddedBlockCipherParameters<CipherParameters, CipherParameters>(ivParam, null);
    final cipher = PaddedBlockCipher('AES/CBC/PKCS7')
      ..init(true, paddedParams); // true는 암호화

    final input = Uint8List.fromList(utf8.encode(plaintext));
    return cipher.process(input);
  }
}

class RsaEncryptionService {
  RSAPublicKey parsePublicKeyFromPKCS8(Uint8List publicKeyBytes) {
    var parser = ASN1Parser(publicKeyBytes);
    var topLevelSeq = parser.nextObject() as ASN1Sequence;
    var publicKeyBitString = topLevelSeq.elements![1] as ASN1BitString;

    // BIT STRING의 첫 번째 바이트를 건너뛰고 파싱
    var publicKeyAsn = ASN1Parser(Uint8List.fromList(publicKeyBitString.valueBytes!.sublist(1)));
    ASN1Sequence publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
    var modulus = publicKeySeq.elements![0] as ASN1Integer;
    var exponent = publicKeySeq.elements![1] as ASN1Integer;

    return RSAPublicKey(modulus.integer!, exponent.integer!);
  }

  Uint8List encrypt(String plaintext, Uint8List publicKeyBytes) {
    final RSAPublicKey publicKey = parsePublicKeyFromPKCS8(publicKeyBytes);

    final cipher = AsymmetricBlockCipher('RSA/PKCS1')
      ..init(true, PublicKeyParameter<RSAPublicKey>(publicKey)); // true는 암호화

    final input = Uint8List.fromList(plaintext.codeUnits);
    return cipher.process(input);
  }

}
