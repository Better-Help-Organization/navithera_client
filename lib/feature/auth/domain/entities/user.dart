import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/notification/data/models/notification_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime? createdAt,
    bool? isEmailAuthenticated,
    String? status,
    String? gender,
    DateTime? dob,
    String? username,
    String? phoneNumber,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact,
    DateTime? deletedAt,
    bool? isLinked,
    bool? isPhoneNumberAuthenticated,
    @JsonKey(name: 'preference')
    List<PrefData>? preferences, // Map 'preference' to 'preferences'
    @JsonKey(name: 'answer') List<AnsData>? answers,
    //@JsonKey(name: 'subscription') List<SubscriptionData>? subscriptions,
    @JsonKey(name: 'activeSubscription') // Match JSON field name
    SubscriptionData? activeSubscription,
    @JsonKey(name: 'expertise') // Add this line
    List<ExpertiseData>? expertise,
    int? avatar,
    String? profile,
    NotificationItem? hasNotification,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
