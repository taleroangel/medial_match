import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/services/image_storage_service.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required UserType type,
    @Default(<Contract>{}) Set<Contract> contracts,
    @Default(<Request>{}) Set<Request> requests,
    @Default(.0) double stars,
    @Default(null) String? presentation,
  }) = _User;

  User._();

  /// Lazy fetch the profile picture
  late final profilePicture =
      GetIt.I.get<IImageStorageService>().fetch("user:$id");

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@JsonEnum(valueField: "code")
enum UserType {
  @JsonValue(0)
  client(0, "Cliente"),
  @JsonValue(1)
  freelancer(1, "Freelancer");

  final int id;
  final String text;
  const UserType(this.id, this.text);
}
