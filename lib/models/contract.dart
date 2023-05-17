import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/models/user.dart';

part 'contract.freezed.dart';
part 'contract.g.dart';

/// Contrato que se establece entre un Cliente y un Freelancer
@freezed
class Contract with _$Contract {
  factory Contract({
    required int id,
    required User freelancer,
    required Service service,
    required double price,
    required String details,
    required int createdAt,
    required int dueAt,
  }) = _Contract;

  Contract._();

  factory Contract.fromJson(Map<String, Object?> json) =>
      _$ContractFromJson(json);
}
