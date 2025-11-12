// chat_repository.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/domain/entities/user.dart';
import 'package:navithera_client/feature/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:navithera_client/feature/chat/data/models/chat_models.dart';
import '../../../../core/error/failures.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatListResponse>> getChatThreads({
    int? page,
    int? limit,
  });

  Future<Either<Failure, Map<String, dynamic>>> createChat({
    required String clientId,
    required String therapistId,
  });

  Future<Either<Failure, void>> markAsRead(String chatId);

  Future<Either<Failure, void>> deleteMessage(String messageId);

  Future<Either<Failure, ChatMessageResponse>> getChatMessages({
    required String chatId,
    int? page,
    int? take,
    String? sort,
  });

  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String content,
  });

  Future<Either<Failure, GroupChatCreateResponse>> createGroupChat({
    required List<String> clientIds,
    required String therapistId,
  });

  Future<Either<Failure, UserModel>> getTherapistInfo(String therapistId);

  Future<Either<Failure, ChatListResponse>> searchChatThreads({
    required String query,
    int? page,
    int? limit,
    String? sort,
  });
}

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ChatListResponse>> getChatThreads({
    int? page,
    int? limit,
    String? sort = 'updatedAt=Desc',
  }) async {
    try {
      final response = await remoteDataSource.getChatThreads(
        page: page,
        take: limit,
        fields: 'client.*,therapist.*,group.*,updatedAt,groupName',
        sort: sort,
      );
      return Right(response);
    } on DioException catch (e) {
      String errorMessage =
          //'Failed to fetch chats';
          "We're having trouble loading your chat. Please check your connection and try again.";
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
  Future<Either<Failure, Map<String, dynamic>>> createChat({
    required String clientId,
    required String therapistId,
  }) async {
    try {
      final response = await remoteDataSource.createChat({
        'client': clientId,
        'therapist': therapistId,
      });
      return Right(response);
    } on DioException catch (e) {
      String errorMessage = 'Failed to create chat';
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
  Future<Either<Failure, ChatMessageResponse>> getChatMessages({
    required String chatId,
    int? page,
    int? take,
    String? sort,
  }) async {
    try {
      final response = await remoteDataSource.getChatMessages(
        chatId,
        page: page,
        take: take,
        sort: sort,
      );
      return Right(response);
    } on DioException catch (e) {
      String errorMessage =
          //'Failed to fetch messages';
          "We're having trouble loading your messages. Please check your connection and try again.";
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
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String content,
  }) async {
    try {
      final response = await remoteDataSource.sendMessage(chatId, {
        'content': content,
      });

      if (response.statusCode == 201) {
        return const Right(null);
      }
      return Left(Failure.serverFailure(response.message));
    } on DioException catch (e) {
      String errorMessage = 'Failed to send message';
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
  Future<Either<Failure, void>> markAsRead(String chatId) async {
    try {
      await remoteDataSource.markAsRead(chatId);
      return const Right(null);
    } on DioException catch (e) {
      String errorMessage = 'Failed to mark chat as read';
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

  // Add to ChatRepositoryImpl
  @override
  Future<Either<Failure, GroupChatCreateResponse>> createGroupChat({
    required List<String> clientIds,
    required String therapistId,
  }) async {
    try {
      final response = await remoteDataSource.createGroupChat({
        'groupClients': clientIds,
        'therapist': therapistId,
      });
      return Right(response);
    } on DioException catch (e) {
      String errorMessage = 'Failed to create group chat';
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
  Future<Either<Failure, UserModel>> getTherapistInfo(
    String therapistId,
  ) async {
    try {
      final response = await remoteDataSource.getTherapistInfo(therapistId);
      return Right(response.data); // Return just the UserModel part
    } on DioException catch (e) {
      String errorMessage =
          // 'Failed to fetch therapist info';
          "We're having trouble loading therapist info. Please check your connection and try again.";
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
  Future<Either<Failure, ChatListResponse>> searchChatThreads({
    required String query,
    int? page,
    int? limit,
    String? sort = 'updatedAt=Desc',
  }) async {
    try {
      final response = await remoteDataSource.getChatThreads(
        page: page,
        take: limit,
        fields: 'therapist.*,group.*,updatedAt',
        sort: sort,
        // You'll need to update the remote data source to accept filter parameter
        filters: 'therapist.firstName=$query', // or implement proper filtering
      );
      return Right(response);
    } on DioException catch (e) {
      String errorMessage = 'Failed to search chats';
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
  Future<Either<Failure, void>> deleteMessage(String messageId) async {
    try {
      await remoteDataSource.deleteMessage(messageId);
      return const Right(null);
    } on DioException catch (e) {
      String errorMessage = 'Failed to delete message';
      if (e.response?.statusCode == 401) {
        errorMessage = 'Unauthorized';
      } else if (e.response?.statusCode == 404) {
        errorMessage = 'Message not found';
      } else if (e.response?.data is Map<String, dynamic>) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remoteDataSource = ref.read(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remoteDataSource);
});
