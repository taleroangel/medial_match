import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/service.dart';

part 'request.freezed.dart';
part 'request.g.dart';

/// Petición sobre un servicio que realiza un cliente
@freezed
class Request with _$Request {
  const factory Request({
    required Service service,
    required Set<Offer> offers,
  }) = _Request;

  factory Request.fromJson(Map<String, Object?> json) =>
      _$RequestFromJson(json);
}
