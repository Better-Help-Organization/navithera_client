// notification_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/notification_models.dart';

part 'notification_remote_data_source.g.dart';

@RestApi()
abstract class NotificationRemoteDataSource {
  factory NotificationRemoteDataSource(Dio dio) = _NotificationRemoteDataSource;

  @GET('/client/me/notifications')
  Future<NotificationListResponse> getNotifications({
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('sort') String? sort,
  });

  @PATCH('/notifications/{id}/read')
  Future<dynamic> markAsRead(@Path('id') String notificationId);

  @POST('/client/me/notifications/read')
  Future<dynamic> markAllAsRead();
}

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>((ref) {
      final dio = ref.read(dioProvider);
      return NotificationRemoteDataSource(dio);
    });
