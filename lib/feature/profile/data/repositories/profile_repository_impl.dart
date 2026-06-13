import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_remote_data_source.dart';
import '../models/profile_models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  @override
  Future<Either<Failure, Profile>> updatePersonalDetails({
    required String firstName,
    required String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  }) async {
    try {
      final request = UpdatePersonalDetailsRequest(
        firstName: firstName,
        lastName: lastName,
        username: username,
        emergencyContact: emergencyContact,
        gender: gender,
      );

      final response = await remoteDataSource.updatePersonalDetails(request);

      final data = response.data;

      final profile = Profile(
        id: data.id,
        firstName: data.firstName,
        lastName: data.lastName,
        email: data.email,
        phoneNumber: data.phoneNumber,
        gender: data.gender,
        username: data.username,
        avatar: data.avatar,
      );

      return Right(profile);
    } on DioException catch (e) {
      String errorMessage = 'Update failed. Please try again.';

      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;

        if (responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        }
      } else if (e.response?.statusCode == 401) {
        errorMessage = 'Authentication failed. Please login again.';
      } else if (e.response?.statusCode == 400) {
        errorMessage = 'Invalid request. Please check your information.';
      } else if (e.response?.statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      }

      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, Profile>> getCurrentProfile() async {
    try {
      final token = await secureStorage.read(key: 'access_token');
      if (token == null) {
        return const Left(Failure.authFailure('No token found'));
      }

      final queries = {
        'fields':
            'preference.*,answer.*,createdAt,firstName,lastName,email,phoneNumber,status,gender,dob,isLinked,username,emergencyContact,isVisible,avatar',
      };

      final response = await remoteDataSource.getCurrentProfile(queries);

      // Convert model to entity
      final profile = Profile(
        id: response.id,
        firstName: response.firstName,
        lastName: response.lastName,
        email: response.email,
        phoneNumber: response.phoneNumber,
        gender: response.gender,
        //dateOfBirth: response.dob,
        username: response.username,
        avatar: response.avatar,
      );

      return Right(profile);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(Failure.authFailure('Authentication failed'));
      }
      return Left(Failure.networkFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}
