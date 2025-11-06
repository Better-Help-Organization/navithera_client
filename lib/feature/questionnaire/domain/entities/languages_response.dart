import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/language_reponse.dart';
import 'therapy_modal.dart';

// part 'languages_reponse.freezed.dart';
// part 'languages_reponse.g.dart';

part 'languages_response.freezed.dart';
part 'languages_response.g.dart';

@freezed
class LanguagesResponse with _$LanguagesResponse {
  const factory LanguagesResponse({required List<LanguageModel> data}) =
      _LanguagesResponse;

  factory LanguagesResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguagesResponseFromJson(json);
}
