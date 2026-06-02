FEATURE INDEX
─────────────────────────────────
Profile picture upload    → Chain 1
Session selection         → Chains 2, 3
Notifications (FCM)       → Chains 4–8
Socket                    → Chains 9–11
Auth gate                 → Chain 12
AI chat (Navi)            → Chains 13, 14
Home screen               → Chains 15–19
Journal                   → Chain 20
Payment                   → Chains 21, 22
Subscription              → Chains 23, 24
Questionnaire             → Chains 25–27
Profile update            → Chain 28
Direct call               → Chains 29, 30
User list                 → Chain 31
Therapist profile         → Chain 32

--------------------------------------------------------------------------------------------------------------------

file_upload_service.dart — triggered when user selects a new profile photo

Chain 1 - upload profile picture
1 - LOCAL SecureStorage.read('access_token')
Read auth token from encrypted storage before making the request
              ↓
2 - TRANSFORM Build multipart request
Detect file extension → resolve MIME type → attach file as multipart field named "file"

              ↓
3 - POST /client/me/upload/profile
Upload image → returns filename from response data

Failure points

Step 1 fails → throws immediately, no upload attempted
Step 3 non-201 → throws with status code, filename never returned

--------------------------------------------------------------------------------------------------------------------

session_selection_service.dart — triggered when user taps "Confirm Selection" in the dialog

Chain 2 — load session options

1 - LOCAL SecureStorage.read('access_token')
Read token before each request — called once per session ID in a loop
              ↓

2 - GET /client/me/sessions/{sessionId}  (×N — one per ID)
Fetch schedule details for each session ID individually → sequential, not parallel

              ↓
3 - TRANSFORM Group and sort sessions
Parse schedule datetimes → group by date → sort by time within each date → render in dialog

Failure points

Any single GET fails → that session silently skipped, others still render
All fail → dialog shows "No sessions available"

--------------------------------------------------------------------------------------------------------------------

Chain 3 — submit session selection

1 - LOCAL SecureStorage.read('access_token')
Read token from encrypted storage

              ↓
2 - POST /session/select
Send selectedId + unselectedIds array → confirms user's chosen session slot

              ↓
3 - GET /client/me (via authProvider.getCurrentUser)
Refresh full user profile after selection is confirmed

              ↓
4 - GET upcomingSessionProvider.loadNext()
Reload upcoming sessions to reflect newly selected slot → then navigate to /auth-gate

Failure points

Step 2 fails → error snackbar shown, dialog closes, steps 3–4 skipped
Step 3 fails → selection succeeded but profile stale until next refresh

--------------------------------------------------------------------------------------------------------------------
notification_service.dart — triggered on incoming FCM push message

Chain 4 — incoming call (foreground / code 5 or 30)

1 - FCM FirebaseMessaging.onMessage
Receive push message with call data embedded in message.data['id']

              ↓
2 - TRANSFORM _parseIncomingCall
JSON-decode data['id'] → extract chatId, room, token, callerName, isVideoCall, isGroupCall

              ↓
3 - LIVEKIT
room.connect(wss://livekit.navithera.com)
Connect to LiveKit room using extracted token → navigate to RoomPage on success

Failure points

Step 2 fails to parse → call silently dropped, no UI shown
Step 3 fails → showErrorDialog shown, room page never opens

--------------------------------------------------------------------------------------------------------------------

Chain 5 — call rejected (code 6 / "Call Ended")

1 - FCM FirebaseMessaging.onMessage
Receive "call ended" push message

              ↓
2 - TRANSFORM _extractChatIdFromMessage
Parse chatId from data['id'] JSON or fallback to data['chatId']

              ↓
3 - CALLKIT
FlutterCallkitIncoming.endAllCalls()

Dismiss native CallKit UI + dismiss any open in-app call dialog

--------------------------------------------------------------------------------------------------------------------

Chain 6 — new message received (code 2)

1 - FCM FirebaseMessaging.onMessage
Receive new chat message push

              ↓
2 - TRANSFORM Parse message data
Decode data['id'] JSON → extract chatId, therapist name, avatar, profile URL → build Chat object

              ↓
3 - REFRESH chatProvider.getChatThreads() + messageProvider.getMessages(chatId)
Silently refresh chat list and messages for the affected chat

              ↓
4 - REFRESH notificationService.fetchUnreadCount()
Update unread badge count in the UI

--------------------------------------------------------------------------------------------------------------------

Chain 7 — status change / subscription update (code 11 or 25)

1 - FCM FirebaseMessaging.onMessage
Receive status change push

              ↓
2 - GET /client/me (via authProvider.getCurrentUser)
Re-fetch full user profile to reflect updated status or subscription

              ↓
3 - NAVIGATE GoRouter.push('/auth-gate')
Re-evaluate routing based on fresh user state

--------------------------------------------------------------------------------------------------------------------

Chain 8 — session selection notification (code 1)

1 - FCM FirebaseMessaging.onMessage
Receive push with sessionIds array in data['id']

              ↓
2 - TRANSFORM Parse sessionIds
JSON-decode data['id'] → extract sessionIds list

              ↓
3 - GET /client/me/sessions/{id} ×N + POST /session/select
Trigger full session selection flow (chains 2 + 3 above)

--------------------------------------------------------------------------------------------------------------------
socket_provider.dart — triggered on app startup / user login

Chain 9 — connect to socket

1 - LOCAL SecureStorage.read('access_token')
Read auth token from encrypted storage — aborts if null

              ↓
2 - TRANSFORM Build socket options
Attach token to socket auth config → set transport to websocket → path /dev/socket.io

              ↓
3 - SOCKET socket.connect() → wss://app.navithera.com
Open persistent WebSocket connection — registers event listeners before connecting

Failure points

Step 1 returns null → silently aborts, no socket opened
Step 3 fails → onConnectError fires, _isConnected stays false, no retry logic

--------------------------------------------------------------------------------------------------------------------

Chain 10 — socket event: userProfileUpdated

1 - SOCKET on('userProfileUpdated')
Server pushes event when any user profile changes

              ↓
2 - REFRESH chatProvider.getChatThreads(silent: true)
Re-fetch full chat thread list to reflect updated profile data (names, avatars)

--------------------------------------------------------------------------------------------------------------------

Chain 11 — socket event: userStatus

1 - SOCKET on('userStatus')
Server pushes userId + isOnline when a user's online status changes

              ↓
2 - TRANSFORM Parse status payload
Cast data to Map → extract userId (String) and isOnline (bool)

              ↓
3 - STATE userStatusProvider.updateStatus(userId, isOnline)
Merge into in-memory status map → UI reactively updates online indicators

Failure points

Step 2 parse error → caught silently, status not updated

--------------------------------------------------------------------------------------------------------------------
auth_gate.dart — triggered whenever AuthState changes to authenticated

Chain 12 — auth gate decision

1 - WATCH authProvider (AuthState)
Reactively listen to auth state — gate activates when state becomes authenticated, carrying full user object

              ↓
2 - SOCKETsocketService.connect()
Open WebSocket connection using stored token (chain 9) — non-blocking, navigation continues even if this fails

              ↓
3 - TRANSFORM Evaluate user state
Inspect user object: hasAnswers, hasPreferences, activeSubscription, subscription status, expiry date, user status, pendingRoute

              ↓
4 - NAVIGATE Route to destination
Decision tree determines the correct screen based on user state flags

Routing decision tree (in order)

no answers + no prefs → /categories
has prefs, no subscription → /categories
no subscription → /subscription
subscription inactive → /payment?preferenceId=...
subscription expired → /categories
user status != active → /blocked-user
subscription status != active → /blocked-user
pending route exists → /main + push pendingRoute
all clear → /main

Failure points

Step 2 (socket) fails → logged and skipped, navigation still proceeds
AuthState = unauthenticated / error / unverified → all redirect to /login
profileError state → no navigation, silently ignored (handler is empty)

--------------------------------------------------------------------------------------------------------------------
ai_chat_remote_data_source.dart + usage_tracking_service.dart — triggered when user sends a message to Navi

Chain 13 — send message to Navi

1 - LOCAL UsageTrackingService.canMakeQuery()
Read query count + last query date from SharedPreferences — auto-resets count if it's a new day

              ↓
2 - LOCAL UsageTrackingService.recordQuery()
Increment query counter in SharedPreferences — recorded before the API call

              ↓
3 - TRANSFORMBuild enhanced prompt
Wrap raw user message with Navi persona instructions → produce final prompt string sent to Cloudflare

              ↓
4 - POST /client/v4/accounts/{accountId}/autorag/rags/{ragId}/ai-search
Send enhanced prompt to Cloudflare AutoRAG → returns AiChatResponse

Failure points

Step 1 returns false → throws daily limit error, steps 2–4 skipped
Step 4 fails (401) → auth error; (403) → permissions error; (429) → Cloudflare rate limit
Step 2 records usage before step 4 — if the API call fails, the query count is still incremented

--------------------------------------------------------------------------------------------------------------------

Chain 14 — get usage info

1 - LOCAL UsageTrackingService.getRemainingQueries()
Read count from SharedPreferences → compute remaining = limit − used

              ↓
2 - LOCAL UsageTrackingService.getQueriesUsedToday()
Read count again from SharedPreferences — separate call, not reusing step 1 result

              ↓
3 - LOCAL UsageTrackingService.isApproachingLimit()
Read count a third time → check if used >= 80% of daily limit

              ↓
4 - TRANSFORM Build UsageInfo object
Combine remaining, used, total, isApproachingLimit, timeUntilReset into a single UsageInfo → returned to UI

Notes
Steps 1–3 each open SharedPreferences independently — 3 sequential reads that could be 1

--------------------------------------------------------------------------------------------------------------------
home_screen.dart — triggered on HomeScreen initState

Chain 15 — home screen bootstrap

1 - LOCAL SecureStorage.read('access_token')
Each service reads token independently — NotificationService, MoodService, QuoteService all call _attachAuthHeader() separately

              ↓ (parallel — all fire on initState)
2a - GET /client/me/notifications → unread count badge
Fetches notification list, reads unreadCount field → updates notificationCountProvider

2b - GET /client/me/moods → today's mood
Fetches last 10 moods, filters client-side by today's date → sets _todayMood

2c - GET /quote/daily → daily quote
Fetches daily quote → sets _quote and _quoteAuthor

2d - GET /client/me/sessions → upcoming session
Fetches next confirmed upcoming session via upcomingSessionProvider

2e - GET /client/me/chats → active calls
Fetches chats with active call rooms via liveSessionProvider

Notes
5 separate token reads from SecureStorage on every home load — one per service
Mood filtering (2b) is done client-side — fetches 10 records to find today's entry

--------------------------------------------------------------------------------------------------------------------
home_screen.dart (LiveSessionService) + room.dart — triggered when user taps "Join Call"

Chain 16 — join active call

1 - LOCAL SecureStorage.read('access_token')
Attach auth header before API call

              ↓
2 - POST /chat/call/{chatId}/join
Join call → returns JoinCallData containing LiveKit room URL and token

              ↓
3 - LIVEKIT room.connect(url, token)
Connect to LiveKit room using credentials from step 2 → navigate to RoomPage

Failure points
Step 2 fails → joinError state, no LiveKit connection attempted
Step 3 fails → showErrorDialog, room never opens

--------------------------------------------------------------------------------------------------------------------

Chain 17 — end call (room.dart)

1 - LIVEKIT RoomDisconnectedEvent fires
Triggered when LiveKit room disconnects — only proceeds if chatId is set and not a group call

              ↓
2 - LOCAL SecureStorage.read('access_token')
Read token to authorize end-call request

              ↓
3 - POST /chat/call/end/{chatId}
Notify server that the call has ended

Failure points
Step 3 fails → silently caught, server never notified call ended

--------------------------------------------------------------------------------------------------------------------
home_screen.dart (MoodService) — triggered when user submits a mood

Chain 18 — submit mood

1 - LOCAL SecureStorage.read('access_token')
Attach auth header

              ↓
2 -  POST /mood
Submit selected mood string → returns 201 on success

--------------------------------------------------------------------------------------------------------------------
home_screen.dart (RatingService) — triggered after session ends

Chain 19 — submit session rating

1 - LOCAL SecureStorage.read('access_token')
Attach auth header

              ↓
2 - POST /ratings
Submit therapistId, rating value (1–5), and optional comment → returns status code

--------------------------------------------------------------------------------------------------------------------
diary_provider.dart — create, update, delete each refresh the list

Chain 20 — create / update / delete diary entry

1 - POST /diary  | PATCH /diary/{id}  | DELETE /diary/{id}
Perform the mutation → on success, immediately triggers a silent list refresh

              ↓
2 - GET /client/me/diary
Re-fetch diary list silently to reflect the change — called after every successful mutation

Failure points
Step 1 fails → error state shown, step 2 skipped, list stays stale
Step 2 fails → mutation succeeded but list may not reflect the change

--------------------------------------------------------------------------------------------------------------------
payment_upload_page.dart — triggered when user picks a file, then separately when they tap Submit

Chain 21 — upload payment document

1 - LOCAL SecureStorage.read('access_token')
Read token before upload

              ↓
2 - TRANSFORM Detect MIME type from file extension
Map extension (jpg/png/pdf/doc/docx) → MIME string → attach as multipart field

              ↓
3 - POST /client/me/upload/payment?subscriptionId={id}
Upload file → returns filename string stored locally as _uploadedFilename

Failure points
Step 1 returns null → throws immediately, no upload attempted
Step 3 fails → _uploadedFilename stays null, Submit button stays disabled

--------------------------------------------------------------------------------------------------------------------

Chain 22 — submit payment

1 - LOCAL Use stored _uploadedFilename from chain 21
Requires chain 21 to have succeeded — filename is a prerequisite for submission

              ↓
2 - LOCAL SecureStorage.read('access_token')
Read token for payment submission

              ↓
3 - POST /payment
Submit subscriptionId, amount, filename, receiptUrl, method → navigate to /auth-gate on success

<!-- Notes
Amount is hardcoded as 455 — not read from user input or subscription data -->

--------------------------------------------------------------------------------------------------------------------
subscription_page.dart — triggered on page load and when user taps a subscription plan

Chain 23 — subscription page load

1 - LOCAL SecureStorage.read('access_token')
Read token — called separately by each service

              ↓ (sequential)
2 - GET /client/me/preferences?fields=level.*,modal.*
Fetch user's preference → extract levelId, levelPrice, modalId, modalName → store in providers

              ↓
3 - GET /subscription?filters=level.id={id},modal.id={id}
Fetch subscriptions filtered by levelId + modalId from step 2 → render plans list

              ↓ (parallel with step 3)
4a - GET /vat → VAT rate
Fetch VAT for price display

4b - GET /exchange-rate → conversion rate
Fetch exchange rate for currency display

Notes
Step 3 depends entirely on step 2 — if preferences are empty, subscription list loads with no filters

--------------------------------------------------------------------------------------------------------------------

Chain 24 — select subscription plan

1 - LOCAL SecureStorage.read('access_token')
Read token for subscription creation

              ↓
2 - POST /subscription
Create user subscription from selected plan → returns new subscriptionId (or extracts existing ID from 409 conflict error message)

              ↓
3 - NAVIGATE /payment?preferenceId={id}
Navigate to payment page passing subscriptionId as extra and preferenceId as query param

Notes
409 conflict is handled by regex-parsing the error message to extract existing subscriptionId — fragile if message format changes

--------------------------------------------------------------------------------------------------------------------
questionnaire_screen.dart + extra_question_screen.dart — multi-step onboarding flow

Chain 25 — complete questionnaire (group modal)

1 - POST /answer
Submit user answers for current modal questions

              ↓
2 - POST /preference
Create preference for group modal using modalId → navigate to /subscription on success

Failure points
Step 1 fails → chain aborts, preference not created
Non-group modal → skips both steps, navigates directly to /language-selection

--------------------------------------------------------------------------------------------------------------------

Chain 26 — extra questions submit (new preference)

1 - POST /answer
Submit questionnaire answers for this modal

              ↓
2 - TRANSFORM Build preference request
Combine languages, level, gender, availability, goals, modalId → create request object (with or without level based on modalId)

              ↓
3 - POST /preference  → then POST /match
Create preference → use returned preferenceId to create therapist match → navigate to /subscription

Notes
If preferenceId exists (update flow) → uses PATCH /preference/{id} instead of POST

--------------------------------------------------------------------------------------------------------------------

Chain 27 — category selection screen load

1 - GET /modal
Fetch therapy modals (categories) on initState → render category options

              ↓ on category tap
2 - NAVIGATE /questionnaire or /language-selection or /subscription
Route depends on user's existing preference state and selected modal type

--------------------------------------------------------------------------------------------------------------------
profile_provider.dart — triggered when user saves profile changes

Chain 28 — update personal details

1 - PATCH /client/me
Update firstName, lastName, username, emergencyContact, gender → returns updated profile

              ↓
2 - GET /client/me (via authProvider.refreshCurrentUser)
Re-fetch full user profile to propagate changes across the app

Failure points
Step 1 fails → error state shown, step 2 skipped
Step 2 fails → profile update succeeded but app-wide user state remains stale (silently caught)

--------------------------------------------------------------------------------------------------------------------
call_provider.dart + call_screen.dart — triggered when a call screen opens directly (not via FCM)

Chain 29 — start direct call (call_provider)

1 - DEVICE Request mic/camera permissions
Request microphone permission (always) and camera permission (video calls only) — aborts chain if denied

              ↓
2 - TRANSFORM Generate LiveKit JWT token
Sign JWT locally using hardcoded apiKey + apiSecret with roomName, participantName, and 24h expiry

              ↓
3 - LIVEKIT room.connect(wss://livekit.navithera.com)
Connect using self-generated token → 30s timeout → start call duration timer on success

Failure points
Step 1 denied → throws immediately, no connection attempted
Step 3 times out after 30s → cleanup called, error state set
LiveKit API key and secret are hardcoded in the provider — a security risk

--------------------------------------------------------------------------------------------------------------------

Chain 30 — end direct call (call_screen / group_call_screen)

1 - LIVEKIT room.disconnect() + room.dispose()
Disconnect from LiveKit room, dispose listener and timer

              ↓
2 - LOCAL SecureStorage.read('access_token')
Read token to authorize end-call API request

              ↓
3 - POST /chat/call/end/{chatId}
Notify server the call has ended — same pattern as chain 17 in room.dart

Notes
call_screen.dart has chatId hardcoded as a default value ('513522dc-...') — should always be passed explicitly
Step 3 fails → silently caught, server not notified

--------------------------------------------------------------------------------------------------------------------
user_list_screen.dart — triggered when therapist taps the chat icon on a client

Chain 31 — create chat from user list

1 - LOCAL currentUserProvider
Read current user from local provider to get therapistId — aborts if null

              ↓
2 - POST /chat
Create chat between clientId and therapistId → returns chatData including new chatId

              ↓
3 - NAVIGATE ChatMessageScreen
Navigate directly to the new chat using returned chatId

Failure points
Step 1 null → shows snackbar, chain aborts
Step 2 fails → shows snackbar with failure message
Chat name in step 3 is hardcoded as "Client" — not pulled from the user object

--------------------------------------------------------------------------------------------------------------------
therapy_profile_screen.dart — triggered on profile screen load

Chain 32 — load therapist ratings

1 - LOCAL SecureStorage.read('access_token')
Read token before fetching ratings

              ↓
2 - GET /therapist/{therapistId}/ratings
Fetch ratings and reviews for the therapist profile being viewed

Notes
The full ratings feature is commented out in the file — this chain exists in code but is currently inactive