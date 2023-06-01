import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/service.dart';

part 'request.freezed.dart';
part 'request.g.dart';

/// Petición sobre un servicio que realiza un cliente
@Freezed(
  equal: false,
)
class Request with _$Request {
  const factory Request({
    required int id,
    required int date,
    required Service service,
    required Set<Offer> offers,
    required String description,

    // UnixTime seconds since epoch
    required int dueAt,
  }) = _Request;

  const Request._();

  @override
  bool operator ==(Object other) => (other is Request) && (other.id == id);

  @override
  int get hashCode => id.hashCode;

  factory Request.fromJson(Map<String, Object?> json) =>
      _$RequestFromJson(json);
}
