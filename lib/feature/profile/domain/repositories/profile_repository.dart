import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> updatePersonalDetails({
    required String firstName,
    required String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  });

  Future<Either<Failure, Profile>> getCurrentProfile();
}
