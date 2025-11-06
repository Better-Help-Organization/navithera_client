import '../../data/models/ai_chat_models.dart';

abstract class AiChatRepository {
  Future<AiChatResponse> sendMessage(String prompt);
}
