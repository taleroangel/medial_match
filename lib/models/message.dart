import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medial_match/models/user.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String content,
    required UserType who,
  }) = _Message;

  factory Message.fromJson(Map<String, Object?> json) =>
      _Message.fromJson(json);
}
