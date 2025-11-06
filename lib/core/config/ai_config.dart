/// Configuration class for AI Chat service
/// Replace these placeholder values with your actual Cloudflare credentials
class AiConfig {
  // TODO: Replace with your actual Cloudflare account ID
  static const String accountId = 'efde9fe22f59c9c0fec906a1b6485e18';

  // TODO: Replace with your actual Cloudflare API token
  static const String apiToken = 'r-LASbMNZCDgxW3x9a0bR2mMUGDsNj_DRcLYbBu0';

  // Cloudflare API base URL
  static const String baseUrl = 'https://api.cloudflare.com';

  // AI model endpoint
  static const String modelEndpoint = '@cf/meta/llama-3.1-8b-instruct';

  // Request timeout settings
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
