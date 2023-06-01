import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medial_match/models/message.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/models/user.dart';

part 'contract.freezed.dart';
part 'contract.g.dart';

/// Contrato que se establece entre un Cliente y un Freelancer
@Freezed(equal: false)
class Contract with _$Contract {
  factory Contract({
    required int id,
    required User freelancer,
    required Service service,
    required double price,
    required String details,

    /// Date of creation in UTC UnixEpochTime in seconds
    required int createdAt,

    /// due date in UTC UnixEpochTime in seconds
    required int dueAt,

    /// Chat
    @Default([]) List<Message> chat,
  }) = _Contract;

  Contract._();

  @override
  bool operator ==(Object other) => (other is Contract) && (other.id == id);

  @override
  int get hashCode => id.hashCode;

  factory Contract.fromJson(Map<String, Object?> json) =>
      _$ContractFromJson(json);
}
