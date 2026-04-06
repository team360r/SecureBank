import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

/// Chapter 4: AES encryption for sensitive data at rest.
class EncryptionService {
  late final encrypt.Key _key;
  late final encrypt.IV _iv;
  late final encrypt.Encrypter _encrypter;

  EncryptionService({required String keyBase64}) {
    _key = encrypt.Key.fromBase64(keyBase64);
    _iv = encrypt.IV.fromLength(16);
    _encrypter = encrypt.Encrypter(encrypt.AES(_key));
  }

  /// Encrypt a plaintext string.
  String encryptText(String plaintext) {
    final encrypted = _encrypter.encrypt(plaintext, iv: _iv);
    return encrypted.base64;
  }

  /// Decrypt a base64-encoded ciphertext.
  String decryptText(String ciphertext) {
    return _encrypter.decrypt64(ciphertext, iv: _iv);
  }

  /// Encrypt a double value (e.g., transaction amount).
  String encryptAmount(double amount) {
    return encryptText(amount.toStringAsFixed(2));
  }

  /// Decrypt to a double value.
  double decryptAmount(String ciphertext) {
    final plaintext = decryptText(ciphertext);
    return double.parse(plaintext);
  }
}
