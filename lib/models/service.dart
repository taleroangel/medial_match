import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:medial_match/services/image_storage_service.dart';

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

  /// Price formatter
  static final priceFormat = NumberFormat("###,###,### \$");

  /// Parse price into [priceFormat]
  String _parsePrice(double? price) =>
      price != null ? priceFormat.format(price) : '?';

  /// Get the price formatted
  String? get price => (priceLower != null && priceUpper != null)
      ? "${_parsePrice(priceLower)} - ${_parsePrice(priceUpper)}"
      : null;
}
