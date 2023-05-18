import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/services/image_storage_service.dart';
import 'package:medial_match/extensions/price_formatter.dart';

part 'service.freezed.dart';
part 'service.g.dart';

@freezed
class Service with _$Service {
  factory Service({
    required int id,
    required String name,
    required String description,
    @Default(null) double? priceLower,
    @Default(null) double? priceUpper,
  }) = _Service;

  factory Service.fromJson(Map<String, Object?> json) =>
      _$ServiceFromJson(json);

  Service._();

  /// Lazy fetch the image
  late final image = GetIt.I.get<IImageStorageService>().fetch("service_$id");

  /// Get the price formatted
  String? get price => (priceLower != null && priceUpper != null)
      ? "${priceLower!.asPrice} - ${priceUpper!.asPrice}"
      : null;
}
