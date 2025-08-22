import 'package:freezed_annotation/freezed_annotation.dart';

part 'stage.freezed.dart';
part 'stage.g.dart';

extension type StageId(String value) {
  factory StageId.fromJson(String value) => StageId(value);
}

@Freezed(toJson: false)
abstract class Stage with _$Stage {
  const factory Stage({
    @JsonKey(fromJson: StageId.fromJson) required StageId id,
    required String title,
  }) = _Stage;

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
}
