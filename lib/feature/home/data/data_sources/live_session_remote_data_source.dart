// feature/home/data/data_sources/live_session_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/live_session_models.dart';

part 'live_session_remote_data_source.g.dart';

@RestApi()
abstract class LiveSessionRemoteDataSource {
  factory LiveSessionRemoteDataSource(Dio dio) = _LiveSessionRemoteDataSource;

  @GET('/client/me/chats')
  Future<ChatListResponse> getChats({
    @Query('fields')
    String? fields=
        'id,activeCallRoom,updatedAt',
            // 'lastMessage.id',
    //         'lastMessage.client.id,lastMessage.client.firstName,lastMessage.client.lastName,'
    //         'lastMessage.therapist.id,lastMessage.therapist.firstName,lastMessage.therapist.lastName,'
    //         'unreadCount',
    @Query('sort') String? sort,
    @Query('take') int? take,
    @Query('page') int? page,
    @Query('filters') String? filters,
  });

  @POST('/chat/call/{id}/join')
  Future<JoinCallResponse> joinCall(@Path('id') String chatId);
}

final liveSessionRemoteDataSourceProvider =
    Provider<LiveSessionRemoteDataSource>((ref) {
      final dio = ref.read(dioProvider);
      return LiveSessionRemoteDataSource(dio);
    });
