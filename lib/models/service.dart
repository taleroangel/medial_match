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
    double? priceLower,
    double? priceUpper,
  }) = _Service;

  Service._();
  late final image = GetIt.I.get<IImageStorageService>().fetch("service_$id");

  static final priceFormat = NumberFormat("###,###,### \$");

  /// Parse price into [priceFormat]
  String _parsePrice(double? price) =>
      price != null ? priceFormat.format(price) : '?';

  /// Get the price parse in correct format
  String? get price => (priceLower != null && priceUpper != null)
      ? "${_parsePrice(priceLower)} - ${_parsePrice(priceUpper)}"
      : null;

  factory Service.fromJson(Map<String, Object?> json) =>
      _$ServiceFromJson(json);
}
