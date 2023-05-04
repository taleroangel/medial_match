import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/services/image_storage_service.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    @UserTypeJsonConverter() required UserType type,
  }) = _User;

  User._();
  late final profilePicture =
      GetIt.I.get<IImageStorageService>().fetch("user_$id");

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

class UserTypeJsonConverter implements JsonConverter<UserType, int> {
  const UserTypeJsonConverter();

  @override
  UserType fromJson(int json) => UserType.values.firstWhere(
        (element) => element.id == json,
      );

  @override
  int toJson(UserType object) => object.id;
}

enum UserType {
  freelancer(0, "Freelancer"),
  client(1, "Cliente");

  final int id;
  final String text;
  const UserType(this.id, this.text);
}
