import 'package:freezed_annotation/freezed_annotation.dart';
import 'therapy_modal.dart';

part 'modals_response.freezed.dart';
part 'modals_response.g.dart';

@freezed
class ModalsResponse with _$ModalsResponse {
  const factory ModalsResponse({
    required List<TherapyModal> data,
  }) = _ModalsResponse;

  factory ModalsResponse.fromJson(Map<String, dynamic> json) =>
      _$ModalsResponseFromJson(json);
}