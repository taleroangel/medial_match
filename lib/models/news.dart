import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/services/image_storage_service.dart';

part 'news.freezed.dart';
part 'news.g.dart';

@freezed
class News with _$News {
  factory News({
    required String title,
    required String content,
    @Default(null) String? imageUrl,
  }) = _News;

  News._();

  /// Lazy fetch the image
  late final imageContent = GetIt.I.get<IImageStorageService>().fetch(imageUrl);

  factory News.fromJson(Map<String, Object?> json) => _$NewsFromJson(json);
}
