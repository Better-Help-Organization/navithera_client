import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    String? gender,
    String? dateOfBirth,
    String? username,
    int? avatar,
  }) = _Profile;
}
