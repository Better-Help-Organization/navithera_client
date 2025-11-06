import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../models/profile_models.dart';

part 'profile_remote_data_source.g.dart';

@RestApi()
abstract class ProfileRemoteDataSource {
  factory ProfileRemoteDataSource(Dio dio) = _ProfileRemoteDataSource;

  @PATCH('/client/me')
  Future<UpdatePersonalDetailsResponse> updatePersonalDetails(
    @Body() UpdatePersonalDetailsRequest request,
  );

  @GET('/client/me')
  Future<ProfileModel> getCurrentProfile(
    @Queries() Map<String, dynamic> queries,
  );
}

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>((
  ref,
) {
  final dio = ref.read(dioProvider);
  return ProfileRemoteDataSource(dio);
});
