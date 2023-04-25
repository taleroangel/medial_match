import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service.freezed.dart';
part 'service.g.dart';

@freezed
class Service with _$Service {
  const factory Service({
    required int id,
    required String name,
    required String description,
    @Default(null) String? image,
  }) = _Service;

  factory Service.mock() {
    final fakerInstance = Faker();

    return Service(
      id: fakerInstance.randomGenerator.integer(1024),
      name: fakerInstance.lorem.sentence(),
      description: fakerInstance.lorem.sentence(),
      image: fakerInstance.image.image(),
    );
  }

  factory Service.fromJson(Map<String, Object?> json) =>
      _$ServiceFromJson(json);
}
