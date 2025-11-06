import 'package:freezed_annotation/freezed_annotation.dart';

// part 'language.freezed.dart';
// part 'language.g.dart';
part 'level_response.freezed.dart';
part 'level_response.g.dart';

@freezed
class LevelModel with _$LevelModel {
  const factory LevelModel({
    required String id,
    required DateTime createdAt,
    required String type,
    required int? minXP,
    required int? maxXP,
    required int? price,
  }) = _LevelModel;

  factory LevelModel.fromJson(Map<String, dynamic> json) =>
      _$LevelModelFromJson(json);
}
