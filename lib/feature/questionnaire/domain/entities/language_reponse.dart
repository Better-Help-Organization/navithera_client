import 'package:freezed_annotation/freezed_annotation.dart';

// part 'language.freezed.dart';
// part 'language.g.dart';
part 'language_reponse.freezed.dart';
part 'language_reponse.g.dart';

@freezed
class LanguageModel with _$LanguageModel {
  const factory LanguageModel({
    required String id,
    required String name,
    required String code,
    required DateTime createdAt,
  }) = _LanguageModel;

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);
}
