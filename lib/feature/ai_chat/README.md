# AI Chat Feature

This feature integrates Cloudflare Workers AI API to provide an AI therapy assistant that users can chat with.

## Setup Instructions

### 1. Get Cloudflare Credentials

1. Sign up for a Cloudflare account at https://cloudflare.com
2. Navigate to the Workers & Pages section
3. Get your Account ID from the right sidebar
4. Create an API token with the necessary permissions

### 2. Configure Credentials

Update the credentials in `lib/core/config/ai_config.dart`:

```dart
class AiConfig {
  // Replace with your actual Cloudflare account ID
  static const String accountId = 'your-actual-account-id-here';

  // Replace with your actual Cloudflare API token
  static const String apiToken = 'your-actual-api-token-here';

  // Other settings can remain as they are
  static const String baseUrl = 'https://api.cloudflare.com';
  static const String modelEndpoint = '@cf/meta/llama-3.1-8b-instruct';
}
```

### 3. How to Access

Users can access the AI chat by tapping the floating action button (psychology icon) in the main navigation. This will open a full-screen chat interface where they can:

- Have conversations with the AI therapy assistant
- Get supportive responses and guidance
- Clear chat history
- Retry failed messages

### 4. API Integration

The implementation uses:

- **Model**: Llama 3.1 8B Instruct (`@cf/meta/llama-3.1-8b-instruct`)
- **HTTP Method**: POST
- **Endpoint**: `https://api.cloudflare.com/client/v4/accounts/{ACCOUNT_ID}/ai/run/@cf/meta/llama-3.1-8b-instruct`
- **Authentication**: Bearer token in Authorization header
- **Request Format**: `{"prompt": "user message here"}`

### 5. Features

- **Beautiful UI**: Modern chat interface with message bubbles
- **Loading States**: Shows typing indicator while waiting for AI response
- **Error Handling**: Displays user-friendly error messages with retry options
- **State Management**: Uses Riverpod for reactive state management
- **Responsive Design**: Works well on different screen sizes

### 6. File Structure

```
lib/feature/ai_chat/
├── data/
│   ├── data_sources/
│   │   ├── ai_chat_remote_data_source.dart
│   │   └── ai_chat_remote_data_source.g.dart
│   ├── models/
│   │   ├── ai_chat_models.dart
│   │   ├── ai_chat_models.freezed.dart
│   │   └── ai_chat_models.g.dart
│   └── repositories/
│       └── ai_chat_repository_impl.dart
├── domain/
│   └── repositories/
│       └── ai_chat_repository.dart
└── presentation/
    ├── pages/
    │   └── ai_chat_screen.dart
    └── providers/
        ├── ai_chat_provider.dart
        └── ai_chat_provider.freezed.dart
```

### 7. Testing

Before deploying to production, test the integration by:

1. Updating the credentials in `ai_config.dart`
2. Running the app
3. Tapping the floating action button
4. Sending a test message
5. Verifying you receive a response from the AI

### 8. Error Messages

The app handles various error scenarios:

- Network connectivity issues
- Authentication failures (401)
- Rate limiting (429)
- Server errors (5xx)
- Request timeouts

Each error displays a user-friendly message with the option to retry the request.
