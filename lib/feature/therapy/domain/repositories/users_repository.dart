// users_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/feature/therapy/data/data_sources/users_remote_data_source.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import '../../../../core/error/failures.dart';
// import '../data_sources/users_remote_data_source.dart';
// import '../models/users_list_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, UsersListResponse>> getUsers({int? page, int? limit});
}

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UsersListResponse>> getUsers({
    int? page,
    int? limit,
  }) async {
    try {
      final response = await remoteDataSource.getUsers(
        page: page,
        limit: limit,
      );
      return Right(response);
    } on DioException catch (e) {
      String errorMessage =
          //'Failed to fetch users';
          "We're having trouble loading chat. Please check your connection and try again.";

      if (e.response?.statusCode == 401) {
        errorMessage = 'Unauthorized';
      } else if (e.response?.data is Map<String, dynamic>) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  final remoteDataSource = ref.read(usersRemoteDataSourceProvider);
  return UsersRepositoryImpl(remoteDataSource);
});
