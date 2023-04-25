import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/services/image_storage_service.dart';

part 'service.freezed.dart';
part 'service.g.dart';

@freezed
class Service with _$Service {
  factory Service({
    required int id,
    required String name,
    required String description,
  }) = _Service;

  Service._();
  late final image = GetIt.I.get<IImageStorageService>().fetch(id.toString());

  factory Service.fromJson(Map<String, Object?> json) =>
      _$ServiceFromJson(json);
}
