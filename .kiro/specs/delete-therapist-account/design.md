# Design Document: Delete Therapist Account

## Overview

This design document outlines the implementation of a delete account feature for therapists in the Navigo Flutter application. The feature follows the existing clean architecture pattern with clear separation between data, domain, and presentation layers. The implementation will integrate seamlessly with the existing profile feature structure and maintain consistency with the app's architecture patterns.

The feature allows therapists to permanently delete their account through a user-initiated action on the profile screen, with appropriate confirmation dialogs to prevent accidental deletion. Upon successful deletion, the user is logged out and redirected to the login/onboarding screen.

## Architecture

The delete account feature follows the clean architecture pattern already established in the profile feature:

```
lib/feature/profile/
├── data/
│   ├── data_sources/
│   │   └── profile_remote_data_source.dart (add deleteAccount method)
│   ├── models/
│   │   └── profile_models.dart (add DeleteAccountResponse model)
│   └── repositories/
│       └── profile_repository_impl.dart (implement deleteAccount)
├── domain/
│   ├── repositories/
│   │   └── profile_repository.dart (add abstract deleteAccount method)
└── presentation/
    ├── pages/
    │   └── profile_screen.dart (add delete button and dialog)
    └── providers/
        └── delete_account_provider.dart (new provider for delete logic)
```

### Layer Responsibilities

**Data Layer:**
- `ProfileRemoteDataSource`: Defines the DELETE API endpoint using Retrofit annotations
- `ProfileRepositoryImpl`: Implements the delete account logic with error handling
- `DeleteAccountResponse`: Model for API response (if needed)

**Domain Layer:**
- `ProfileRepository`: Abstract interface defining the deleteAccount contract

**Presentation Layer:**
- `ProfileScreen`: UI for delete account button and confirmation dialog
- `DeleteAccountProvider`: Riverpod provider managing delete account state and logic

## Components and Interfaces

### 1. Data Layer Components

#### ProfileRemoteDataSource Extension

Add a new method to the existing `ProfileRemoteDataSource`:

```dart
@DELETE('/account/client')
Future<HttpResponse<void>> deleteAccount();
```

This uses Retrofit's `@DELETE` annotation to call the endpoint `/api/v1/account/client`. The method returns `HttpResponse<void>` since we only care about the status code, not response body content.

#### ProfileRepositoryImpl Extension

Add implementation to `ProfileRepositoryImpl`:

```dart
@override
Future<Either<Failure, Unit>> deleteAccount() async {
  try {
    final response = await remoteDataSource.deleteAccount();
    
    if (response.response.statusCode >= 200 && response.response.statusCode < 300) {
      return const Right(unit);
    } else {
      return Left(Failure.serverFailure('Failed to delete account'));
    }
  } on DioException catch (e) {
    String errorMessage = 'Failed to delete account. Please try again.';
    
    if (e.response?.data is Map<String, dynamic>) {
      final responseData = e.response!.data as Map<String, dynamic>;
      if (responseData.containsKey('message')) {
        errorMessage = responseData['message'].toString();
      }
    } else if (e.response?.statusCode == 401) {
      errorMessage = 'Authentication failed. Please login again.';
    } else if (e.response?.statusCode == 403) {
      errorMessage = 'You do not have permission to delete this account.';
    } else if (e.response?.statusCode == 500) {
      errorMessage = 'Server error. Please try again later.';
    } else if (e.type == DioExceptionType.connectionTimeout || 
               e.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Connection timeout. Please check your internet connection.';
    }
    
    return Left(Failure.serverFailure(errorMessage));
  } catch (e) {
    return Left(Failure.unknownFailure('An unexpected error occurred'));
  }
}
```

The implementation follows the existing error handling pattern in the profile repository, using `Either<Failure, Unit>` to represent success or failure. The `Unit` type from dartz represents a successful operation with no return value.

### 2. Domain Layer Components

#### ProfileRepository Extension

Add abstract method to `ProfileRepository`:

```dart
Future<Either<Failure, Unit>> deleteAccount();
```

This defines the contract that the data layer must implement.

### 3. Presentation Layer Components

#### DeleteAccountProvider

Create a new Riverpod provider to manage delete account state:

```dart
@riverpod
class DeleteAccount extends _$DeleteAccount {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();
    
    final repository = ref.read(profileRepositoryProvider);
    final result = await repository.deleteAccount();
    
    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) {
        state = const AsyncValue.data(null);
      },
    );
  }
}
```

This provider uses Riverpod's code generation and manages the async state of the delete operation.

#### ProfileScreen UI Extension

Add a delete account button to the "More" section of the profile screen:

```dart
_buildListTile(
  icon: Icons.delete_outline,
  title: AppLocalizations.of(context)!.deleteAccount,
  onTap: () => _showDeleteAccountDialog(context),
  isDestructive: true,
),
```

The button should be styled similarly to the logout button with error/destructive colors.

#### Confirmation Dialog

Implement a confirmation dialog method:

```dart
Future<void> _showDeleteAccountDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(AppLocalizations.of(context)!.deleteAccount),
      content: Text(AppLocalizations.of(context)!.deleteAccountConfirmation),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await _handleDeleteAccount();
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.error,
          ),
          child: Text(AppLocalizations.of(context)!.confirmDelete),
        ),
      ],
    ),
  );
}
```

#### Delete Account Handler

Implement the handler that coordinates the delete operation:

```dart
Future<void> _handleDeleteAccount() async {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );
  
  // Trigger delete operation
  await ref.read(deleteAccountProvider.notifier).deleteAccount();
  
  // Dismiss loading indicator
  if (mounted) Navigator.pop(context);
  
  // Check result
  final deleteState = ref.read(deleteAccountProvider);
  
  deleteState.when(
    data: (_) async {
      // Success - show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.accountDeletedSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
      
      // Logout and cleanup
      await ref.read(authProvider.notifier).logout();
      ref.read(matchedTherapistProvider.notifier).reset();
      ref.read(upcomingSessionProvider.notifier).reset();
      
      // Dispose socket
      final socketService = ref.read(socketServiceProvider.notifier);
      socketService.state.disconnect();
      ref.invalidate(socketServiceProvider);
      
      // Navigate to login
      if (mounted) {
        ref.read(routerProvider).go('/login');
      }
    },
    error: (error, _) {
      // Error - show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    },
    loading: () {},
  );
}
```

## Data Models

### DeleteAccountResponse (Optional)

If the API returns a response body, create a model:

```dart
@JsonSerializable()
class DeleteAccountResponse {
  final String message;
  final bool success;
  
  DeleteAccountResponse({
    required this.message,
    required this.success,
  });
  
  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$DeleteAccountResponseToJson(this);
}
```

However, based on the existing patterns and the DELETE endpoint specification, we likely don't need a response model since we only care about the HTTP status code.

## Localization Strings

Add the following keys to all `.arb` files:

### English (app_en.arb)
```json
{
  "deleteAccount": "Delete Account",
  "deleteAccountConfirmation": "Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.",
  "confirmDelete": "Delete",
  "accountDeletedSuccess": "Your account has been successfully deleted",
  "deleteAccountError": "Failed to delete account. Please try again."
}
```

### Amharic (app_am.arb)
```json
{
  "deleteAccount": "መለያ ሰርዝ",
  "deleteAccountConfirmation": "መለያዎን መሰረዝ ይፈልጋሉ? ይህ ድርጊት መልሰው ማግኘት አይችሉም እና ሁሉም መረጃዎ ለዘለቄታው ይሰረዛል።",
  "confirmDelete": "ሰርዝ",
  "accountDeletedSuccess": "መለያዎ በተሳካ ሁኔታ ተሰርዟል",
  "deleteAccountError": "መለያ መሰረዝ አልተሳካም። እባክዎ እንደገና ይሞክሩ።"
}
```

### Oromo (app_om.arb)
```json
{
  "deleteAccount": "Akkaawuntii Haquu",
  "deleteAccountConfirmation": "Akkaawuntii kee haquu barbaaddaa? Gocha kun duubatti hin deebi'u fi daataan kee hundi yeroo hundaaf ni haqama.",
  "confirmDelete": "Haquu",
  "accountDeletedSuccess": "Akkaawuntiin kee milkaa'inaan haqameera",
  "deleteAccountError": "Akkaawuntii haquun hin milkoofne. Maaloo irra deebi'ii yaali."
}
```

### Somali (app_so.arb)
```json
{
  "deleteAccount": "Tirtir Akoonka",
  "deleteAccountConfirmation": "Ma hubtaa inaad rabto inaad tirtirto akoonkaaga? Tallaabadan lama celin karo oo dhammaan xogtaada waa la tirtiri doonaa weligeed.",
  "confirmDelete": "Tirtir",
  "accountDeletedSuccess": "Akoonkaaga si guul leh ayaa loo tirtiray",
  "deleteAccountError": "Tirtirka akoonka waa lagu guuldarraystay. Fadlan mar kale isku day."
}
```

### Tigrinya (app_ti.arb)
```json
{
  "deleteAccount": "ሂሳብ ምስራዝ",
  "deleteAccountConfirmation": "ሂሳብካ ክትስርዞ ትደሊ ዲኻ? እዚ ተግባር ምምላስ ዘይከኣል እዩ እሞ ኩሉ ሓበሬታኻ ንዘለኣለም ክስረዝ እዩ።",
  "confirmDelete": "ስረዝ",
  "accountDeletedSuccess": "ሂሳብካ ብዓወት ተሰሪዙ",
  "deleteAccountError": "ሂሳብ ምስራዝ ኣይተዓወተን። በጃኻ ደጊምካ ፈትን።"
}
```


## Correctness Properties

*A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.*

### Property 1: Localization Consistency

*For any* supported locale (English, Amharic, Oromo, Somali, Tigrinya), all delete account UI elements (button text, dialog messages, success messages, error messages) should display text from the Localization_Service in that locale.

**Validates: Requirements 1.3, 2.6, 4.5, 5.5, 6.6**

### Property 2: Confirmation Dialog Display

*For any* profile screen state, when the delete account button is tapped, a confirmation dialog should be displayed before any deletion logic executes.

**Validates: Requirements 2.1**

### Property 3: Cancel Preserves State

*For any* profile screen state, tapping the "Cancel" button in the confirmation dialog should dismiss the dialog and leave the application state unchanged (idempotence of cancel).

**Validates: Requirements 2.4**

### Property 4: Confirm Triggers Deletion

*For any* authenticated therapist, when the "Confirm Delete" button is tapped in the confirmation dialog, the delete account API call should be initiated.

**Validates: Requirements 2.5**

### Property 5: Correct API Endpoint

*For any* delete account request, the system should send a DELETE HTTP request to the endpoint /api/v1/account/client with the configured base URL.

**Validates: Requirements 3.1, 3.2**

### Property 6: Authentication Headers Included

*For any* delete account API request, the request should include valid authentication credentials in the headers.

**Validates: Requirements 3.3**

### Property 7: Loading Indicator During Request

*For any* delete account operation, while the API request is in progress, a loading indicator should be visible to the user.

**Validates: Requirements 3.4**

### Property 8: Network Error Handling

*For any* network error (timeout, connection failure, DNS failure), the system should handle the error gracefully and display an appropriate error message without crashing.

**Validates: Requirements 3.5**

### Property 9: Success Response Handling

*For any* HTTP response with status code in the range 200-299, the system should display a success message to the user.

**Validates: Requirements 4.1**

### Property 10: Logout After Successful Deletion

*For any* successful account deletion response, the Auth_Service should be called to log out the therapist.

**Validates: Requirements 4.2**

### Property 11: Auth Data Cleanup

*For any* logout operation triggered by account deletion, all stored authentication tokens and user data should be cleared from local storage.

**Validates: Requirements 4.3**

### Property 12: Navigation After Logout

*For any* completed logout operation following account deletion, the Navigation_Service should navigate the user to the login or onboarding screen.

**Validates: Requirements 4.4**

### Property 13: Error Response Handling

*For any* HTTP response with status code in the range 400-599, the system should display an error message to the user without logging them out.

**Validates: Requirements 5.1**

### Property 14: Network Error Message Display

*For any* network error (not HTTP error), the system should display a network-specific error message to the user.

**Validates: Requirements 5.2**

### Property 15: Server Error Message Passthrough

*For any* error response containing a "message" field in the response body, that message should be displayed to the user.

**Validates: Requirements 5.3**

### Property 16: Session Preservation on Error

*For any* error during account deletion (network error or HTTP error), the user's session should remain active and the user should remain on the Profile_Screen.

**Validates: Requirements 5.4**

## Error Handling

The delete account feature implements comprehensive error handling at multiple layers:

### Network Layer Errors

**Connection Timeouts:**
- Detected via `DioExceptionType.connectionTimeout`
- User-facing message: "Connection timeout. Please check your internet connection."
- No state changes occur
- User remains authenticated and on profile screen

**Receive Timeouts:**
- Detected via `DioExceptionType.receiveTimeout`
- User-facing message: "Connection timeout. Please check your internet connection."
- No state changes occur

**Network Unavailable:**
- Detected via `DioExceptionType.connectionError`
- User-facing message: "Network error. Please check your connection."
- No state changes occur

### HTTP Error Responses

**401 Unauthorized:**
- Indicates authentication failure
- User-facing message: "Authentication failed. Please login again."
- User remains on profile screen
- Session remains active (user can retry after re-authenticating)

**403 Forbidden:**
- Indicates permission denied
- User-facing message: "You do not have permission to delete this account."
- User remains on profile screen
- Session remains active

**400 Bad Request:**
- Indicates invalid request format
- User-facing message: Server message if available, otherwise "Invalid request."
- User remains on profile screen

**500 Internal Server Error:**
- Indicates server-side error
- User-facing message: "Server error. Please try again later."
- User remains on profile screen
- User can retry later

**Other Error Codes:**
- Generic error handling
- User-facing message: Server message if available, otherwise "Failed to delete account. Please try again."

### Presentation Layer Errors

**Dialog Dismissal:**
- If user navigates away during operation, loading dialog is safely dismissed
- Uses `mounted` check before showing UI feedback
- Prevents crashes from showing dialogs on unmounted widgets

**State Management Errors:**
- Provider errors are caught and displayed via SnackBar
- Error state is maintained in the provider
- User can retry the operation

### Success Flow Error Prevention

**Logout Sequence:**
- Logout is only triggered after confirmed successful deletion (HTTP 2xx)
- All cleanup operations (reset providers, disconnect socket) happen before navigation
- Navigation only occurs if widget is still mounted

**Data Cleanup:**
- Socket disconnection is handled gracefully
- Provider invalidation prevents stale state
- SharedPreferences cleanup ensures no auth data remains

## Testing Strategy

The delete account feature requires both unit tests and property-based tests to ensure comprehensive coverage and correctness.

### Unit Testing Approach

Unit tests focus on specific examples, edge cases, and integration points:

**Widget Tests:**
- Verify delete account button appears on profile screen
- Verify confirmation dialog displays with correct content (warning message, two buttons)
- Verify dialog buttons have correct labels
- Test that tapping cancel dismisses dialog
- Test that tapping confirm triggers delete logic
- Verify loading indicator appears during operation
- Verify success SnackBar appears on success
- Verify error SnackBar appears on error

**Repository Tests:**
- Test successful deletion returns Right(unit)
- Test 401 error returns appropriate Failure
- Test 403 error returns appropriate Failure
- Test 500 error returns appropriate Failure
- Test connection timeout returns appropriate Failure
- Test server message extraction from error response
- Test that authentication headers are included in request

**Provider Tests:**
- Test initial state is AsyncValue.data(null)
- Test state becomes loading when deleteAccount is called
- Test state becomes data on success
- Test state becomes error on failure
- Test error message is extracted correctly

**Localization Tests:**
- Verify all required keys exist in app_en.arb
- Verify all required keys exist in app_am.arb
- Verify all required keys exist in app_om.arb
- Verify all required keys exist in app_so.arb
- Verify all required keys exist in app_ti.arb

**Integration Tests:**
- Test complete success flow: button tap → dialog → confirm → API call → logout → navigation
- Test complete error flow: button tap → dialog → confirm → API error → error message → remain on screen
- Test cancel flow: button tap → dialog → cancel → dialog dismissed → no API call

### Property-Based Testing Approach

Property-based tests verify universal properties across many generated inputs. Each test should run a minimum of 100 iterations.

**Test Library:** Use the `test` package with custom property test helpers, or consider `fast_check` if available for Dart.

**Property Test Configuration:**
- Minimum 100 iterations per test
- Each test tagged with: `Feature: delete-therapist-account, Property {N}: {property text}`

**Property Tests to Implement:**

1. **Localization Consistency (Property 1)**
   - Generate: Random locale from supported set
   - Test: All UI strings come from localization service for that locale
   - Tag: `Feature: delete-therapist-account, Property 1: Localization Consistency`

2. **Confirmation Dialog Display (Property 2)**
   - Generate: Random profile screen state
   - Test: Tapping delete button shows dialog
   - Tag: `Feature: delete-therapist-account, Property 2: Confirmation Dialog Display`

3. **Cancel Preserves State (Property 3)**
   - Generate: Random profile screen state
   - Test: State before cancel == state after cancel
   - Tag: `Feature: delete-therapist-account, Property 3: Cancel Preserves State`

4. **Confirm Triggers Deletion (Property 4)**
   - Generate: Random authenticated user
   - Test: Confirm button triggers API call
   - Tag: `Feature: delete-therapist-account, Property 4: Confirm Triggers Deletion`

5. **Correct API Endpoint (Property 5)**
   - Generate: Random delete request
   - Test: Request URL matches expected endpoint
   - Tag: `Feature: delete-therapist-account, Property 5: Correct API Endpoint`

6. **Authentication Headers Included (Property 6)**
   - Generate: Random authenticated user
   - Test: Request includes auth headers
   - Tag: `Feature: delete-therapist-account, Property 6: Authentication Headers Included`

7. **Loading Indicator During Request (Property 7)**
   - Generate: Random delete operation
   - Test: Loading indicator visible while request in progress
   - Tag: `Feature: delete-therapist-account, Property 7: Loading Indicator During Request`

8. **Network Error Handling (Property 8)**
   - Generate: Random network error type (timeout, connection failure, DNS)
   - Test: Error handled gracefully, error message shown, no crash
   - Tag: `Feature: delete-therapist-account, Property 8: Network Error Handling`

9. **Success Response Handling (Property 9)**
   - Generate: Random HTTP 2xx status code
   - Test: Success message displayed
   - Tag: `Feature: delete-therapist-account, Property 9: Success Response Handling`

10. **Logout After Successful Deletion (Property 10)**
    - Generate: Random successful deletion response
    - Test: Logout method called
    - Tag: `Feature: delete-therapist-account, Property 10: Logout After Successful Deletion`

11. **Auth Data Cleanup (Property 11)**
    - Generate: Random logout operation
    - Test: All auth tokens and user data cleared
    - Tag: `Feature: delete-therapist-account, Property 11: Auth Data Cleanup`

12. **Navigation After Logout (Property 12)**
    - Generate: Random completed logout
    - Test: Navigation to login/onboarding occurs
    - Tag: `Feature: delete-therapist-account, Property 12: Navigation After Logout`

13. **Error Response Handling (Property 13)**
    - Generate: Random HTTP 4xx or 5xx status code
    - Test: Error message displayed, user not logged out
    - Tag: `Feature: delete-therapist-account, Property 13: Error Response Handling`

14. **Network Error Message Display (Property 14)**
    - Generate: Random network error
    - Test: Network-specific error message displayed
    - Tag: `Feature: delete-therapist-account, Property 14: Network Error Message Display`

15. **Server Error Message Passthrough (Property 15)**
    - Generate: Random error response with message field
    - Test: Server message displayed to user
    - Tag: `Feature: delete-therapist-account, Property 15: Server Error Message Passthrough`

16. **Session Preservation on Error (Property 16)**
    - Generate: Random error (network or HTTP)
    - Test: Session remains active, user on Profile_Screen
    - Tag: `Feature: delete-therapist-account, Property 16: Session Preservation on Error`

### Test Coverage Goals

- **Unit Tests:** Cover specific examples and edge cases
- **Property Tests:** Cover universal behaviors across all inputs
- **Integration Tests:** Cover end-to-end flows
- **Target:** 90%+ code coverage for the delete account feature
- **Focus:** Both happy path and error scenarios

### Mocking Strategy

**For Unit Tests:**
- Mock `ProfileRemoteDataSource` to return controlled responses
- Mock `SharedPreferences` for auth token storage
- Mock `AuthProvider` to verify logout is called
- Mock `RouterProvider` to verify navigation

**For Property Tests:**
- Use property test generators to create random inputs
- Mock external dependencies (API, storage, navigation)
- Verify properties hold across all generated inputs

**For Integration Tests:**
- Use real widgets and providers
- Mock only external services (API, storage)
- Test actual user interactions and state changes
