// upcoming_session_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/home/data/data_sources/upcoming_session_remote_data_source.dart';
import 'package:navithera_client/feature/home/data/models/upcoming_session_models.dart';

abstract class UpcomingSessionRepository {
  Future<Either<Failure, SessionListResponse>> getUpcomingSessions({
    int? page,
    int? take,
  });

  Future<Either<Failure, SessionItem?>> getNextUpcomingSession();
}

class UpcomingSessionRepositoryImpl implements UpcomingSessionRepository {
  final UpcomingSessionRemoteDataSource remote;

  UpcomingSessionRepositoryImpl(this.remote);

  // upcoming_session_repository.dart
  // In upcoming_session_repository.dart
  @override
  Future<Either<Failure, SessionListResponse>> getUpcomingSessions({
    int? page,
    int? take,
  }) async {
    try {
      final now = DateTime.now().toIso8601String();
      final res = await remote.getUpcomingSessions(
        page: page,
        take: take,
        sort: 'schedule=asc',
        filters:
            'schedule>$now,hasTherapistAttended=0,approvalStatus=confirmed',
        // Add fields to include therapist data
        fields:
            'id,schedule,approvalStatus,hasTherapistAttended,hasclientAttended,'
            'duration,type,note,'
            'therapist.*',
      );
      return Right(res);
    } on DioException catch (e) {
      String msg =
          "We're having trouble loading your sessions. Please check your connection and try again.";
      if (e.response?.statusCode == 401) {
        msg = 'Unauthorized';
      } else if (e.response?.data is Map<String, dynamic>) {
        msg = e.response?.data['message'] ?? msg;
      }
      return Left(Failure.serverFailure(msg));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SessionItem?>> getNextUpcomingSession() async {
    final result = await getUpcomingSessions(take: 1, page: 1);
    return result.fold((l) => Left(l), (r) {
      if (r.data.isNotEmpty) {
        final nextSession = r.data.first;
        print(
          'Next session found: ${nextSession.id} at ${nextSession.schedule}',
        );
        return Right(nextSession);
      }
      print('No upcoming sessions found');
      return const Right(null);
    });
  }
}

final upcomingSessionRepositoryProvider = Provider<UpcomingSessionRepository>((
  ref,
) {
  final remote = ref.read(upcomingSessionRemoteDataSourceProvider);
  return UpcomingSessionRepositoryImpl(remote);
});
