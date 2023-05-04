// ignore_for_file: prefer-match-file-name

import 'dart:typed_data';

import 'package:medial_match/exceptions/content_does_not_exist_exception.dart';

abstract class IImageStorageService {
  /// Fetch content from Storage
  /// Returns bytes of content
  /// Throws [ContentDoesNotExistException] when content does not exist
  Future<Uint8List> fetch(String? resource);

  /// Store content in Storage
  Future<bool> store(Future<Uint8List> content);
}
