import 'package:dartz/dartz.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(
    String phoneNumber,
    String password,
    String fcm,
  );

  Future<Either<Failure, User>> signup(
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
    String firebaseToken,
    String dob,
    String username,
    String phoneNumber,
  );

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
  //Future<Either<Failure, User>> getCurrentUserFromBackend();
  Future<Either<Failure, User>> getUserFromBackend();
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, User>> updateProfile(UpdateProfileRequest request);
  Future<Either<Failure, User>> updateProfilePic(
    UpdateProfilePicRequest request,
  );
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, String>> resetPassword(
    String email,
    String password,
    String passwordConfirm,
    String otp,
  );
}
