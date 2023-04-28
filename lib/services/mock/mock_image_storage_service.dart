import 'dart:io';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/exceptions/content_does_not_exist_error.dart';
import 'package:medial_match/services/image_storage_service.dart';
import 'package:http/http.dart' as http;

/// Generate mock images emulating 'Storage'
class MockImageStorageService implements IImageStorageService {
  /// LoremPicksum endpoint for random images
  static const _mockUrl = "https://picsum.photos/400";

  MockImageStorageService() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  Future<Uint8List> _mockNetworkFetch() async {
    final result = await http.get(Uri.parse(_mockUrl));

    if (result.statusCode != HttpStatus.ok) {
      GetIt.I.get<Logger>().w(
            "[HTTP] Failed fetch from: ${result.request?.url}",
          );

      throw ContentDoesNotExistError();
    }

    return result.bodyBytes;
  }

  @override
  Future<Uint8List> fetch(String? resource) => _mockNetworkFetch();

  @override
  Future<bool> store(Future<Uint8List> content) {
    throw UnimplementedError();
  }
}
