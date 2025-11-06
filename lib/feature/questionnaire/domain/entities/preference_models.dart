// preference_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_models.freezed.dart';
part 'preference_models.g.dart';

@freezed
class PreferenceRequest with _$PreferenceRequest {
  const factory PreferenceRequest({
    required String modalId,
    required String gender,
    required List<String> languageIds,
    //String? sessionFormat,
    String? goal,
    required String levelId,
    required List<AvailabilitySlot> availability,
  }) = _PreferenceRequest;

  factory PreferenceRequest.fromJson(Map<String, dynamic> json) =>
      _$PreferenceRequestFromJson(json);
}

@freezed
class PreferenceRequestWithoutLevel with _$PreferenceRequestWithoutLevel {
  const factory PreferenceRequestWithoutLevel({
    required String modalId,
    required String gender,
    required List<String> languageIds,
    String? goal,
    // levelId is omitted entirely for special modal
    required List<AvailabilitySlot> availability,
  }) = _PreferenceRequestWithoutLevel;

  factory PreferenceRequestWithoutLevel.fromJson(Map<String, dynamic> json) =>
      _$PreferenceRequestWithoutLevelFromJson(json);
}

@freezed
class PreferenceRequestModalOnly with _$PreferenceRequestModalOnly {
  const factory PreferenceRequestModalOnly({required String modalId}) =
      _PreferenceRequestModalOnly;

  factory PreferenceRequestModalOnly.fromJson(Map<String, dynamic> json) =>
      _$PreferenceRequestModalOnlyFromJson(json);
}

@freezed
class AvailabilitySlot with _$AvailabilitySlot {
  const factory AvailabilitySlot({
    required String day,
    required String day_period,
  }) = _AvailabilitySlot;

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) =>
      _$AvailabilitySlotFromJson(json);
}

@freezed
class PreferenceResponse with _$PreferenceResponse {
  const factory PreferenceResponse({
    required PreferenceData data,
    required String message,
    required int statusCode,
    String? method,
    String? path,
    String? timestamp,
  }) = _PreferenceResponse;

  factory PreferenceResponse.fromJson(Map<String, dynamic> json) =>
      _$PreferenceResponseFromJson(json);
}

@freezed
class PreferenceGroupResponse with _$PreferenceGroupResponse {
  const factory PreferenceGroupResponse({
    // required PreferenceData data,
    required String message,
    required int statusCode,
    String? method,
    String? path,
    String? timestamp,
  }) = _PreferenceGroupResponse;

  factory PreferenceGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$PreferenceGroupResponseFromJson(json);
}

@freezed
class PreferenceData with _$PreferenceData {
  const factory PreferenceData({
    required String gender,
    // required String sessionFormat,
    String? goal,
    Client? client,
    Modal? modal,
    List<Language>? language,
    Level? level,
    List<Availability>? availability,
    String? updatedAt,
    String? id,
    required String createdAt,
    String? deletedAt,
  }) = _PreferenceData;

  factory PreferenceData.fromJson(Map<String, dynamic> json) =>
      _$PreferenceDataFromJson(json);
}

@freezed
class Client with _$Client {
  const factory Client({required String id}) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}

@freezed
class Modal with _$Modal {
  const factory Modal({required String id}) = _Modal;

  factory Modal.fromJson(Map<String, dynamic> json) => _$ModalFromJson(json);
}

@freezed
class Language with _$Language {
  const factory Language({required String id}) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
}

@freezed
class Level with _$Level {
  const factory Level({required String id}) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}

@freezed
class Availability with _$Availability {
  const factory Availability({
    required String day,
    required String day_period,
    // required int duration,
    // required String timezone,
    required String updatedAt,
    required String id,
    required String createdAt,
    String? deletedAt,
  }) = _Availability;

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);
}

@freezed
class MatchRequest with _$MatchRequest {
  const factory MatchRequest({required String preferenceId}) = _MatchRequest;

  factory MatchRequest.fromJson(Map<String, dynamic> json) =>
      _$MatchRequestFromJson(json);
}

@freezed
class MatchResponse with _$MatchResponse {
  const factory MatchResponse({
    required MatchData data,
    required String message,
    required int statusCode,
    String? method,
    String? path,
    String? timestamp,
  }) = _MatchResponse;

  factory MatchResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchResponseFromJson(json);
}

@freezed
class MatchData with _$MatchData {
  const factory MatchData({required String message}) = _MatchData;

  factory MatchData.fromJson(Map<String, dynamic> json) =>
      _$MatchDataFromJson(json);
}
