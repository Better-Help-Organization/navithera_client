// upcoming_session_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/upcoming_session_models.dart';

part 'upcoming_session_remote_data_source.g.dart';

@RestApi()
abstract class UpcomingSessionRemoteDataSource {
  factory UpcomingSessionRemoteDataSource(Dio dio) =
      _UpcomingSessionRemoteDataSource;

  @GET('/client/me/sessions')
  Future<SessionListResponse> getUpcomingSessions({
    @Query('filters') String? filters,
    @Query('sort') String? sort,
    @Query('take') int? take = 20,
    @Query('page') int? page,
    @Query('fields')
    String? fields =
        'id,schedule,approvalStatus,hasTherapistAttended,hasclientAttended,'
            'duration,type,note,'
            'therapist.id,therapist.firstName,therapist.lastName,therapist.avatar',
  });
}

final upcomingSessionRemoteDataSourceProvider =
    Provider<UpcomingSessionRemoteDataSource>((ref) {
      final dio = ref.read(dioProvider);
      return UpcomingSessionRemoteDataSource(dio);
    });
