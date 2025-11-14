// matched_therapist_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/home/data/data_sources/matched_therapist_remote_data_source.dart';
import 'package:navithera_client/feature/home/data/models/matched_therapist_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

abstract class MatchedTherapistRepository {
  Future<Either<Failure, UserModel?>> getLatestAcceptedTherapist();
}

class MatchedTherapistRepositoryImpl implements MatchedTherapistRepository {
  final MatchedTherapistRemoteDataSource remote;

  MatchedTherapistRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, UserModel?>> getLatestAcceptedTherapist() async {
    try {
      final res = await remote.getMatches(
        fields: 'accepted.*,createdAt',
        sort: 'createdAt=desc',
        take: 10,
        page: 1,
      );

      // Take the first match regardless of whether it has an accepted therapist
      if (res.data.isNotEmpty) {
        final firstMatch = res.data.first;
        return Right(firstMatch.accepted);
      }

      return const Right(null);
    } on DioException catch (e) {
      String msg =
          //'Failed to fetch matched therapist';
          "We're having trouble loading therapist info. Please check your connection and try again.";
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

final matchedTherapistRepositoryProvider = Provider<MatchedTherapistRepository>(
  (ref) {
    final remote = ref.read(matchedTherapistRemoteDataSourceProvider);
    return MatchedTherapistRepositoryImpl(remote);
  },
);
