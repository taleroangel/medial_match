import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medial_match/models/user.dart';

part 'offer.freezed.dart';
part 'offer.g.dart';

/// Oferta que se realiza sobre un servicio por un freelancer
@freezed
class Offer with _$Offer {
  const factory Offer({
    required User freelancer,
    required double price,
  }) = _Offer;

  factory Offer.fromJson(Map<String, Object?> json) => _$OfferFromJson(json);
}
