import '../../domain/repositories/ai_chat_repository.dart';
import '../data_sources/ai_chat_remote_data_source.dart';
import '../models/ai_chat_models.dart';

class AiChatRepositoryImpl implements AiChatRepository {
  final AiChatService _service;

  AiChatRepositoryImpl(this._service);

  @override
  Future<AiChatResponse> sendMessage(String prompt) async {
    return await _service.sendMessage(prompt);
  }
}
