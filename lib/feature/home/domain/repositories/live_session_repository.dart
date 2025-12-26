// feature/home/domain/repositories/live_session_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/home/data/data_sources/live_session_remote_data_source.dart';
import 'package:navithera_client/feature/home/data/models/live_session_models.dart';

abstract class LiveSessionRepository {
  Future<Either<Failure, List<ChatItem>>> getActiveCalls();
  Future<Either<Failure, JoinCallData>> joinCall(String chatId);
}

class LiveSessionRepositoryImpl implements LiveSessionRepository {
  final LiveSessionRemoteDataSource remote;

  LiveSessionRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ChatItem>>> getActiveCalls() async {
    try {
      // Filter for chats with activeCallRoom !== null
      final res = await remote.getChats(
        filters: 'activeCallRoom!==null',
        sort: 'updatedAt=desc',
        take: 10,
        page: 1,
      );

      return Right(res.data);
    } on DioException catch (e) {
      String msg = "Unable to fetch active calls. Please try again.";
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
  Future<Either<Failure, JoinCallData>> joinCall(String chatId) async {
    try {
      final res = await remote.joinCall(chatId);
      if (res.data != null) {
        return Right(res.data!);
      }
      return Left(Failure.serverFailure('Failed to join call'));
    } on DioException catch (e) {
      String msg = "Unable to join the call. Please try again.";
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
}

final liveSessionRepositoryProvider = Provider<LiveSessionRepository>((ref) {
  final remote = ref.read(liveSessionRemoteDataSourceProvider);
  return LiveSessionRepositoryImpl(remote);
});
