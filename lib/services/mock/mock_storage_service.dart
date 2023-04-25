import 'dart:io';
import 'dart:typed_data';

import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/exceptions/content_does_not_exist_error.dart';
import 'package:medial_match/services/storage_service.dart';
import 'package:http/http.dart' as http;

class MockStorageService implements IStorageService {
  MockStorageService() {
    GetIt.I.get<Logger>().d(
          "Generated $runtimeType",
        );
  }

  final _fakerInstance = Faker();

  Future<Uint8List> _mockNetworkFetch() async {
    final result = await http.get(Uri.parse(_fakerInstance.image.image()));

    if (result.statusCode != HttpStatus.ok) {
      GetIt.I.get<Logger>().w(
            "[HTTP] Failed fetch from: ${result.request?.url}",
          );

      throw ContentDoesNotExistError();
    }

    return result.bodyBytes;
  }

  @override
  Future<Uint8List> fetch(String resource) => _mockNetworkFetch();

  @override
  Future<bool> store(Future<Uint8List> content) {
    throw UnimplementedError();
  }
}
