// chat_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/domain/entities/user.dart';
import 'package:retrofit/retrofit.dart';
import '../models/chat_models.dart';

part 'chat_remote_data_source.g.dart';

@RestApi()
abstract class ChatRemoteDataSource {
  factory ChatRemoteDataSource(Dio dio) = _ChatRemoteDataSource;

  @GET('/client/me/chats')
  Future<ChatListResponse> getChatThreads({
    @Query('page') int? page,
    @Query('take') int? take = 1,
    @Query('fields') String? fields =
        'id,updatedAt'
            'therapist.id,therapist.email,therapist.firstName,therapist.lastName,'
            'therapist.createdAt,therapist.avatar,therapist.isOnline,'
            'group.id,group.email,group.firstName,group.lastName,'
            'group.createdAt,group.avatar,'
            'lastMessage.id,lastMessage.content,lastMessage.createdAt,lastMessage.isRead,'
            'unreadCount,groupName',
    @Query('sort') String? sort,
    @Query('filters') String? filters,
  });

  @POST('/chat')
  Future<dynamic> createChat(@Body() Map<String, dynamic> request);

  @GET('/chat/{id}/messages')
  Future<ChatMessageResponse> getChatMessages(
    @Path('id') String chatId, {
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('sort') String? sort,
    @Query('fields')
    String? fields =
        'id,content,createdAt'
            // 'therapist.id,therapist.firstName,therapist.lastName,therapist.avatar,'
            // 'client.id,client.firstName,client.lastName,client.avatar',
  });

  @PATCH('/chat/{id}/read')
  Future<dynamic> markAsRead(@Path('id') String chatId);

  @POST('/chat/{id}/messages')
  Future<MessageSendResponse> sendMessage(
    @Path('id') String chatId,
    @Body() Map<String, dynamic> message,
  );

  @POST('/chat')
  Future<GroupChatCreateResponse> createGroupChat(
    @Body() Map<String, dynamic> request,
  );

  @GET('/therapist/{id}')
  Future<TherapistInfoResponse> getTherapistInfo(
    @Path('id') String therapistId, {
    @Query('fields')
    String? fields =
        'id,firstName,lastName,createdAt,avatar,bio,isOnline,'
            'expertise.id,expertise.expertise',
  });

  @DELETE('/messages/{id}')
  Future<dynamic> deleteMessage(@Path('id') String messageId);
}

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return ChatRemoteDataSource(dio);
});
