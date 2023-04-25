// ignore_for_file: prefer-match-file-name

import 'dart:typed_data';

abstract class IStorageService {
  /// Fetch content from Storage
  Future<Uint8List> fetch(String resource);

  /// Store content in Storage
  Future<bool> store(Future<Uint8List> content);
}
