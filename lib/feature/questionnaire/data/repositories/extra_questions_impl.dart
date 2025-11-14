// extra_questions_impl.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:navithera_client/feature/questionnaire/data/datasources/extra_questions_data_source.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/languages_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/levels_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/repositories/extra_questions_repository.dart';
import '../../../../core/error/failures.dart';

class ExtraQuestionsImpl implements ExtraQuestionsRepository {
  final ExtraQuestionsDataSource remoteDataSource;

  ExtraQuestionsImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LanguagesResponse>> getLanguages() async {
    try {
      final result = await remoteDataSource.getLanguages();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LevelsResponse>> getLevels() async {
    try {
      final result = await remoteDataSource.getLevel();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceResponse>> createPreference(
    PreferenceRequest request,
  ) async {
    try {
      final response = await remoteDataSource.createPreference(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceResponse>> createPreferenceWithoutLevel(
    PreferenceRequestWithoutLevel request,
  ) async {
    try {
      final response = await remoteDataSource.createPreferenceWithoutLevel(
        request,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceGroupResponse>> createPreferenceForGroup(
    PreferenceRequestModalOnly request,
  ) async {
    try {
      final response = await remoteDataSource.createPreferenceForGroup(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MatchResponse>> createMatch(
    MatchRequest request,
  ) async {
    try {
      final response = await remoteDataSource.createMatch(request);
      return Right(response);
    } on DioException catch (e) {
      // if (e.response?.statusCode == 400) {
      //   return Left(InvalidInputFailure('Invalid match data'));
      // } else if (e.response?.statusCode == 404) {
      //   return Left(NotFoundFailure('Preference not found'));
      // }
      return Left(ServerFailure(e.message ?? 'Unknown error occurred'));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, PreferenceResponse>> updatePreference(
    String preferenceId,
    PreferenceUpdateRequest request,
  ) async {
    try {
      final response = await remoteDataSource.updatePreference(
        preferenceId,
        request,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PreferenceResponse>> updatePreferenceWithoutLevel(
    String preferenceId,
    PreferenceUpdateWithoutLevelRequest request,
  ) async {
    try {
      final response = await remoteDataSource.updatePreferenceWithoutLevel(
        preferenceId,
        request,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // We'll add more methods here as we implement more questions
  // For example:
  // Future<Either<Failure, SessionFormatsResponse>> getSessionFormats();
  // Future<Either<Failure, AvailabilityResponse>> getAvailabilityOptions();
}
