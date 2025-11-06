// notification_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/notification/data/data_sources/notification_remote_data_source.dart';
import 'package:navithera_client/feature/notification/data/models/notification_models.dart';

abstract class NotificationRepository {
  Future<Either<Failure, NotificationListResponse>> getNotifications({
    int? page,
    int? limit,
  });

  Future<Either<Failure, void>> markAsRead(String notificationId);

  Future<Either<Failure, void>> markAllAsRead();
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, NotificationListResponse>> getNotifications({
    int? page,
    int? limit,
  }) async {
    try {
      final response = await remoteDataSource.getNotifications(
        page: page,
        take: limit,
        sort: 'createdAt=Desc',
      );
      return Right(response);
    } on DioException catch (e) {
      String errorMessage =
          // 'Failed to fetch notifications';
          "We're having trouble loading your notifications. Please check your connection and try again.";
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

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    try {
      await remoteDataSource.markAsRead(notificationId);
      return const Right(null);
    } on DioException catch (e) {
      String errorMessage = 'Failed to mark notification as read';
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

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await remoteDataSource.markAllAsRead();
      return const Right(null);
    } on DioException catch (e) {
      String errorMessage = 'Failed to mark all notifications as read';
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

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final remoteDataSource = ref.read(notificationRemoteDataSourceProvider);
  return NotificationRepositoryImpl(remoteDataSource);
});
