# Implementation Plan: Delete Therapist Account

## Overview

This implementation plan breaks down the delete therapist account feature into discrete, incremental coding tasks. Each task builds on previous work and includes specific file modifications. The feature follows clean architecture principles with clear separation between data, domain, and presentation layers.

## Tasks

- [x] 1. Add localization strings for all supported languages
  - Add keys to lib/l10n/app_en.arb: deleteAccount, deleteAccountConfirmation, confirmDelete, accountDeletedSuccess, deleteAccountError
  - Add translations to lib/l10n/app_am.arb (Amharic)
  - Add translations to lib/l10n/app_om.arb (Oromo)
  - Add translations to lib/l10n/app_so.arb (Somali)
  - Add translations to lib/l10n/app_ti.arb (Tigrinya)
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [ ]* 1.1 Write unit tests for localization strings
  - Verify all required keys exist in each .arb file
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [x] 2. Extend domain layer with delete account contract
  - [x] 2.1 Add abstract deleteAccount method to ProfileRepository interface
    - Open lib/feature/profile/domain/repositories/profile_repository.dart
    - Add method signature: `Future<Either<Failure, Unit>> deleteAccount();`
    - _Requirements: 7.4_

- [x] 3. Implement data layer for delete account API
  - [x] 3.1 Add DELETE endpoint to ProfileRemoteDataSource
    - Open lib/feature/profile/data/data_sources/profile_remote_data_source.dart
    - Add method with @DELETE annotation: `@DELETE('/account/client') Future<HttpResponse<void>> deleteAccount();`
    - Run build_runner to generate code: `dart run build_runner build`
    - _Requirements: 3.1, 3.2, 7.2_

  - [x] 3.2 Implement deleteAccount in ProfileRepositoryImpl
    - Open lib/feature/profile/data/repositories/profile_repository_impl.dart
    - Implement deleteAccount method with comprehensive error handling
    - Handle DioException for network errors (timeout, connection failure)
    - Handle HTTP error codes (401, 403, 400, 500)
    - Extract server error messages from response body
    - Return Either<Failure, Unit> with appropriate error messages
    - _Requirements: 3.1, 3.3, 3.5, 5.1, 5.2, 5.3, 7.3_

  - [ ]* 3.3 Write unit tests for ProfileRepositoryImpl.deleteAccount
    - Test successful deletion returns Right(unit)
    - Test 401 error returns auth failure
    - Test 403 error returns permission failure
    - Test 500 error returns server failure
    - Test connection timeout returns network failure
    - Test server message extraction
    - _Requirements: 3.1, 3.5, 5.1, 5.2, 5.3_

  - [ ]* 3.4 Write property test for API endpoint correctness
    - **Property 5: Correct API Endpoint**
    - **Validates: Requirements 3.1, 3.2**
    - Generate random delete requests
    - Verify DELETE method and correct endpoint URL
    - Tag: `Feature: delete-therapist-account, Property 5: Correct API Endpoint`

  - [ ]* 3.5 Write property test for authentication headers
    - **Property 6: Authentication Headers Included**
    - **Validates: Requirements 3.3**
    - Generate random authenticated users
    - Verify auth headers present in all requests
    - Tag: `Feature: delete-therapist-account, Property 6: Authentication Headers Included`

  - [ ]* 3.6 Write property test for network error handling
    - **Property 8: Network Error Handling**
    - **Validates: Requirements 3.5**
    - Generate random network error types
    - Verify graceful handling and error messages
    - Tag: `Feature: delete-therapist-account, Property 8: Network Error Handling`

- [x] 4. Create presentation layer provider for delete account
  - [x] 4.1 Create DeleteAccountProvider with Riverpod
    - Create file: lib/feature/profile/presentation/providers/delete_account_provider.dart
    - Implement provider using @riverpod annotation
    - Add deleteAccount method that calls repository
    - Manage AsyncValue state (loading, data, error)
    - _Requirements: 7.5_

  - [ ]* 4.2 Write unit tests for DeleteAccountProvider
    - Test initial state is AsyncValue.data(null)
    - Test state becomes loading when deleteAccount called
    - Test state becomes data on success
    - Test state becomes error on failure
    - Mock ProfileRepository for controlled responses
    - _Requirements: 7.5_

  - [ ]* 4.3 Write property test for success response handling
    - **Property 9: Success Response Handling**
    - **Validates: Requirements 4.1**
    - Generate random HTTP 2xx status codes
    - Verify success message displayed
    - Tag: `Feature: delete-therapist-account, Property 9: Success Response Handling`

  - [ ]* 4.4 Write property test for error response handling
    - **Property 13: Error Response Handling**
    - **Validates: Requirements 5.1**
    - Generate random HTTP 4xx/5xx status codes
    - Verify error message displayed, user not logged out
    - Tag: `Feature: delete-therapist-account, Property 13: Error Response Handling`

- [ ] 5. Checkpoint - Ensure backend integration tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 6. Add delete account UI to ProfileScreen
  - [x] 6.1 Add delete account button to ProfileScreen
    - Open lib/feature/profile/presentation/pages/profile_screen.dart
    - Add _buildListTile for delete account in "More" section (before logout)
    - Use Icons.delete_outline icon
    - Set isDestructive: true for error color styling
    - Use AppLocalizations.of(context)!.deleteAccount for text
    - Call _showDeleteAccountDialog on tap
    - _Requirements: 1.1, 1.2, 1.3_

  - [x] 6.2 Implement confirmation dialog
    - Add _showDeleteAccountDialog method to ProfileScreen
    - Create AlertDialog with title, warning message, and two buttons
    - Cancel button dismisses dialog
    - Confirm Delete button (styled with error color) calls _handleDeleteAccount
    - Use localized strings for all text
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6_

  - [x] 6.3 Implement delete account handler
    - Add _handleDeleteAccount method to ProfileScreen
    - Show loading dialog (CircularProgressIndicator)
    - Call ref.read(deleteAccountProvider.notifier).deleteAccount()
    - Dismiss loading dialog when complete
    - Check result with deleteState.when()
    - On success: show success SnackBar, logout, cleanup, navigate to login
    - On error: show error SnackBar with error message
    - Use mounted checks before showing UI
    - _Requirements: 3.4, 4.1, 4.2, 4.3, 4.4, 5.1, 5.4_

  - [ ]* 6.4 Write widget tests for delete account button
    - Verify delete account button appears on profile screen
    - Verify button has correct icon and text
    - Verify button has destructive styling
    - _Requirements: 1.1_

  - [ ]* 6.5 Write widget tests for confirmation dialog
    - Verify dialog displays when button tapped
    - Verify dialog contains warning message
    - Verify dialog has Cancel and Confirm Delete buttons
    - Verify Cancel dismisses dialog
    - Verify Confirm Delete triggers delete logic
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

  - [ ]* 6.6 Write property test for confirmation dialog display
    - **Property 2: Confirmation Dialog Display**
    - **Validates: Requirements 2.1**
    - Generate random profile screen states
    - Verify tapping delete button shows dialog
    - Tag: `Feature: delete-therapist-account, Property 2: Confirmation Dialog Display`

  - [ ]* 6.7 Write property test for cancel preserves state
    - **Property 3: Cancel Preserves State**
    - **Validates: Requirements 2.4**
    - Generate random profile screen states
    - Verify state unchanged after cancel
    - Tag: `Feature: delete-therapist-account, Property 3: Cancel Preserves State`

  - [ ]* 6.8 Write property test for confirm triggers deletion
    - **Property 4: Confirm Triggers Deletion**
    - **Validates: Requirements 2.5**
    - Generate random authenticated users
    - Verify confirm button triggers API call
    - Tag: `Feature: delete-therapist-account, Property 4: Confirm Triggers Deletion`

  - [ ]* 6.9 Write property test for loading indicator
    - **Property 7: Loading Indicator During Request**
    - **Validates: Requirements 3.4**
    - Generate random delete operations
    - Verify loading indicator visible during request
    - Tag: `Feature: delete-therapist-account, Property 7: Loading Indicator During Request`

  - [ ]* 6.10 Write property test for localization consistency
    - **Property 1: Localization Consistency**
    - **Validates: Requirements 1.3, 2.6, 4.5, 5.5, 6.6**
    - Generate random locales from supported set
    - Verify all UI strings come from localization service
    - Tag: `Feature: delete-therapist-account, Property 1: Localization Consistency`

- [x] 7. Implement logout and navigation flow
  - [x] 7.1 Integrate logout sequence in success handler
    - In _handleDeleteAccount success branch, call authProvider.logout()
    - Reset matchedTherapistProvider and upcomingSessionProvider
    - Disconnect and invalidate socketServiceProvider
    - Clear SharedPreferences auth tokens
    - Navigate to /login using routerProvider
    - _Requirements: 4.2, 4.3, 4.4_

  - [ ]* 7.2 Write property test for logout after deletion
    - **Property 10: Logout After Successful Deletion**
    - **Validates: Requirements 4.2**
    - Generate random successful deletion responses
    - Verify logout method called
    - Tag: `Feature: delete-therapist-account, Property 10: Logout After Successful Deletion`

  - [ ]* 7.3 Write property test for auth data cleanup
    - **Property 11: Auth Data Cleanup**
    - **Validates: Requirements 4.3**
    - Generate random logout operations
    - Verify all auth tokens and user data cleared
    - Tag: `Feature: delete-therapist-account, Property 11: Auth Data Cleanup`

  - [ ]* 7.4 Write property test for navigation after logout
    - **Property 12: Navigation After Logout**
    - **Validates: Requirements 4.4**
    - Generate random completed logouts
    - Verify navigation to login/onboarding
    - Tag: `Feature: delete-therapist-account, Property 12: Navigation After Logout`

- [x] 8. Implement comprehensive error handling
  - [x] 8.1 Add error message display in handler
    - Ensure all error paths show appropriate SnackBar messages
    - Use localized error messages where applicable
    - Pass through server error messages when available
    - Maintain session and stay on ProfileScreen on error
    - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

  - [ ]* 8.2 Write property test for network error message display
    - **Property 14: Network Error Message Display**
    - **Validates: Requirements 5.2**
    - Generate random network errors
    - Verify network-specific error messages
    - Tag: `Feature: delete-therapist-account, Property 14: Network Error Message Display`

  - [ ]* 8.3 Write property test for server error message passthrough
    - **Property 15: Server Error Message Passthrough**
    - **Validates: Requirements 5.3**
    - Generate random error responses with message field
    - Verify server message displayed
    - Tag: `Feature: delete-therapist-account, Property 15: Server Error Message Passthrough`

  - [ ]* 8.4 Write property test for session preservation on error
    - **Property 16: Session Preservation on Error**
    - **Validates: Requirements 5.4**
    - Generate random errors (network or HTTP)
    - Verify session active, user on ProfileScreen
    - Tag: `Feature: delete-therapist-account, Property 16: Session Preservation on Error`

- [ ] 9. Integration testing and end-to-end flows
  - [ ]* 9.1 Write integration test for complete success flow
    - Test: button tap → dialog → confirm → API call → logout → navigation
    - Use real widgets and providers, mock only API
    - Verify each step in sequence
    - _Requirements: 1.1, 2.1, 2.5, 3.1, 4.2, 4.4_

  - [ ]* 9.2 Write integration test for complete error flow
    - Test: button tap → dialog → confirm → API error → error message → remain on screen
    - Verify session remains active
    - Verify user can retry
    - _Requirements: 1.1, 2.1, 2.5, 5.1, 5.4_

  - [ ]* 9.3 Write integration test for cancel flow
    - Test: button tap → dialog → cancel → dialog dismissed → no API call
    - Verify no state changes
    - _Requirements: 1.1, 2.1, 2.4_

- [ ] 10. Final checkpoint - Ensure all tests pass
  - Run all unit tests, property tests, and integration tests
  - Verify code coverage meets 90%+ target
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Property tests should run minimum 100 iterations each
- Use existing patterns from lib/feature/profile/ for consistency
- All localization strings must be added before UI implementation
- Error handling is critical - test all error paths thoroughly
- Integration tests verify end-to-end flows work correctly
