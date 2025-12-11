/// Configuration class for AI Chat service with Cloudflare AutoRAG
class AiConfig {
  // Cloudflare account ID
  static const String accountId = 'efde9fe22f59c9c0fec906a1b6485e18';

  // Cloudflare API token for AutoRAG
  static const String apiToken = 't4wItBYP7UkRKjpthqSiGFajc8cHjwOrE1b51DE5';

  // Cloudflare API base URL
  static const String baseUrl = 'https://api.cloudflare.com';

  // AutoRAG ID
  static const String ragId = 'navitheras-rag';

  // AutoRAG endpoint path
  static String get autoRagEndpoint =>
      '/client/v4/accounts/$accountId/autorag/rags/$ragId/ai-search';

  // Request timeout settings
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
