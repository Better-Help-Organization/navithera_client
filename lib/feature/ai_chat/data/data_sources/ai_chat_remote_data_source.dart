import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/ai_chat_models.dart';
import '../../../../core/config/ai_config.dart';
import 'usage_tracking_service.dart';

part 'ai_chat_remote_data_source.g.dart';

@RestApi()
abstract class AiChatRemoteDataSource {
  factory AiChatRemoteDataSource(Dio dio) = _AiChatRemoteDataSource;

  @POST('/client/v4/accounts/{accountId}/autorag/rags/{ragId}/ai-search')
  Future<AiChatResponse> sendMessage(
    @Path('accountId') String accountId,
    @Path('ragId') String ragId,
    @Body() AiChatRequest request,
  );
}

class AiChatService {
  final Dio _dio = Dio();
  late final AiChatRemoteDataSource _dataSource;
  final UsageTrackingService _usageService = UsageTrackingService();

  AiChatService() {
    _dio.options.baseUrl = AiConfig.baseUrl;
    _dio.options.connectTimeout = AiConfig.connectTimeout;
    _dio.options.receiveTimeout = AiConfig.receiveTimeout;
    _dio.options.headers['Authorization'] = 'Bearer ${AiConfig.apiToken}';
    _dio.options.headers['Content-Type'] = 'application/json';

    _dataSource = AiChatRemoteDataSource(_dio);
  }

  /// Check if user can make a query
  Future<bool> canMakeQuery() async {
    return await _usageService.canMakeQuery();
  }

  /// Get remaining queries for today
  Future<int> getRemainingQueries() async {
    return await _usageService.getRemainingQueries();
  }

  /// Get usage information
  Future<UsageInfo> getUsageInfo() async {
    final remaining = await _usageService.getRemainingQueries();
    final used = await _usageService.getQueriesUsedToday();
    final isApproaching = await _usageService.isApproachingLimit();
    final timeUntilReset = _usageService.getTimeUntilReset();

    return UsageInfo(
      remaining: remaining,
      used: used,
      total: _usageService.dailyLimit,
      isApproachingLimit: isApproaching,
      timeUntilReset: timeUntilReset,
    );
  }

  Future<AiChatResponse> sendMessage(String prompt) async {
    // Check if user has exceeded daily limit
    if (!await _usageService.canMakeQuery()) {
      throw Exception(
        'Daily query limit exceeded. You can make ${_usageService.dailyLimit} queries per day. Please try again tomorrow.',
      );
    }

    try {
      // Record the query usage
      await _usageService.recordQuery();

      // Enhance prompt with therapy assistant context
      final finalPrompt =
          '''You are Navi, a helpful AI therapy assistant. The user is asking: "$prompt"
          Please provide supportive, empathetic guidance while being professional.Answer clearly and directly, focusing only on what was asked. nothing extra answer is needed.
''';
      final request = AiChatRequest(query: finalPrompt);
      return await _dataSource.sendMessage(
        AiConfig.accountId,
        AiConfig.ragId,
        request,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
          'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return Exception(
            'Authentication failed. Please check your API token.',
          );
        } else if (statusCode == 403) {
          return Exception(
            'Access forbidden. Please check your account permissions.',
          );
        } else if (statusCode == 429) {
          return Exception('Rate limit exceeded. Please try again later.');
        } else {
          return Exception('Server error: ${e.response?.statusMessage}');
        }
      case DioExceptionType.cancel:
        return Exception('Request was cancelled.');
      case DioExceptionType.unknown:
      default:
        return Exception(
          'Network error. Please check your internet connection.',
        );
    }
  }
}
