import 'package:freezed_annotation/freezed_annotation.dart';

part 'stage.freezed.dart';
part 'stage.g.dart';

@freezed
abstract class Stage with _$Stage {
  const factory Stage({
    required String id, // ランダム
    required String title,
  }) = _Stage;

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
}
