// matched_therapist_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/matched_therapist_models.dart';

part 'matched_therapist_remote_data_source.g.dart';

@RestApi()
abstract class MatchedTherapistRemoteDataSource {
  factory MatchedTherapistRemoteDataSource(Dio dio) =
      _MatchedTherapistRemoteDataSource;

  @GET('/client/me/matches')
  Future<MatchListResponse> getMatches({
    @Query('fields') String? fields,
    @Query('sort') String? sort,
    @Query('take') int? take,
    @Query('page') int? page,
    @Query('filters') String? filters,
  });
}

final matchedTherapistRemoteDataSourceProvider =
    Provider<MatchedTherapistRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return MatchedTherapistRemoteDataSource(dio);
});
