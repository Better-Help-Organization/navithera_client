import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/journal/data/data_sources/diary_remote_data_source.dart';
import 'package:navithera_client/feature/journal/data/models/diary_models.dart';

abstract class DiaryRepository {
  Future<Either<Failure, DiaryListResponse>> getDiaryEntries({
    int? page,
    int? take,
    String? sort,
  });

  Future<Either<Failure, DiaryCreateResponse>> createDiaryEntry({
    required String title,
    required String content,
  });

  Future<Either<Failure, DiaryEditResponse>> updateDiaryEntry({
    // Changed return type
    required String id,
    required String title,
    required String content,
  });

  Future<Either<Failure, DiaryEditResponse>> deleteDiaryEntry(String id);
}

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryRemoteDataSource _remoteDataSource;

  DiaryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, DiaryListResponse>> getDiaryEntries({
    int? page,
    int? take,
    String? sort,
  }) async {
    try {
      final response = await _remoteDataSource.getDiaryEntries(
        page: page,
        take: take,
        sort: sort,
      );
      return Right(response);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DiaryCreateResponse>> createDiaryEntry({
    required String title,
    required String content,
  }) async {
    try {
      final response = await _remoteDataSource.createDiaryEntry({
        'title': title,
        'content': content,
      });
      return Right(response);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DiaryEditResponse>> updateDiaryEntry({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final response = await _remoteDataSource.updateDiaryEntry(id, {
        'title': title,
        'content': content,
      });
      return Right(response);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DiaryEditResponse>> deleteDiaryEntry(String id) async {
    try {
      final response = await _remoteDataSource.deleteDiaryEntry(id);
      return Right(response);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}

final diaryRepositoryProvider = Provider<DiaryRepository>((ref) {
  final remoteDataSource = ref.read(diaryRemoteDataSourceProvider);
  return DiaryRepositoryImpl(remoteDataSource);
});
