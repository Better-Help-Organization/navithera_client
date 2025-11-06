// users_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/users_list_model.dart';

part 'users_remote_data_source.g.dart';

@RestApi()
abstract class UsersRemoteDataSource {
  factory UsersRemoteDataSource(Dio dio) = _UsersRemoteDataSource;

  @GET('/client')
  Future<UsersListResponse> getUsers({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });
}

final usersRemoteDataSourceProvider = Provider<UsersRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return UsersRemoteDataSource(dio);
});
