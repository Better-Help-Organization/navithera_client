// levels_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'level_response.dart';

part 'levels_response.freezed.dart';
part 'levels_response.g.dart';

@freezed
class LevelsResponse with _$LevelsResponse {
  const factory LevelsResponse({
    required List<LevelModel> data, // This should contain LevelModel items
  }) = _LevelsResponse;

  factory LevelsResponse.fromJson(Map<String, dynamic> json) =>
      _$LevelsResponseFromJson(json);
}
