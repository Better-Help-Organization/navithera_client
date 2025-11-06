import 'package:freezed_annotation/freezed_annotation.dart';

part 'therapy_modal.freezed.dart';
part 'therapy_modal.g.dart';

@freezed
class TherapyModal with _$TherapyModal {
  const factory TherapyModal({
    required String id,
    required String name,
    required String description,
    required DateTime createdAt,
  }) = _TherapyModal;

  factory TherapyModal.fromJson(Map<String, dynamic> json) =>
      _$TherapyModalFromJson(json);
}
