
Summary of Endpoints to Optimize
Endpoint                        Source File                     Eager Fields Count      Priority
GET /client/me                  auth                            5                       HIGH
GET /client/me (after update)   auth                            2                       HIGH
GET /client/me/chats            chat                            3                       HIGH
GET /client/me/chats            live_session                    1                       HIGH
GET /client/me/sessions         upcoming_session                3                       HIGH
GET /client/me/sessions/:id     session_selection_service       2                       MEDIUM
GET /client/me/matches          matched_therapist               3                       HIGH
GET /client/me/notifications    notification                    2                       MEDIUM
GET /client/me/diary            diary                           1                       MEDIUM
GET /client                     users                           1                       MEDIUM
GET /chat/{id}/messages         chat                            4                       HIGH
GET /therapist/{id}             chat                            5                       HIGH

Detailed Endpoint Analysis

------------------------------------------------------------------------------------------------------------------------------------------

1. GET /client/me
File: auth_remote_data_source.dart
Called from: getCurrentUserProfile(), also re-called after every updateProfile() and updateProfilePicture()

Field / Pattern         Description                                                    Risk
preference.*           Full preference object with all sub-fields via wildcard         HIGH
answer.*               All questionnaire answers with all sub-fields via wildcard      HIGH
subscription.*         All subscriptions, potentially an array                         HIGH
activeSubscription.*   Active subscription with all sub-fields via wildcard            MEDIUM
hasNotification.*      Notification objects with all sub-fields via wildcard           MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

2. GET /client/me/chats
File: chat_remote_data_source.dart
Called from: getChatThreads() — also triggered on every app resume via lifecycle observer in main.dart

Field / Pattern               Description                                                Risk
No fields param passed        Backend returns full default chat objects                  HIGH
Nested participant profiles   Full therapist/user profile inside each thread             HIGH
Last message object           Possibly full message object instead of preview only       MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

3. GET /client/me/chats (Live Session context)
File: live_session_remote_data_source.dart
Called from: getChats() in live session feature

Field / Pattern          Description                                             Risk
No fields param passed   Same endpoint as above, same over-fetching problem      HIGH

------------------------------------------------------------------------------------------------------------------------------------------

4. GET /client/me/sessions
File: upcoming_session_remote_data_source.dart
Called from: getUpcomingSessions(), also called after session selection

Field / Pattern                            Description                                      Risk
No fields param passed at call sites       Full session objects returned by default         HIGH
Nested therapist profile                   Full therapist object inside each session        HIGH
Nested subscription info                   Subscription object linked to session            MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

5. GET /client/me/sessions/:id
File: session_selection_service.dart
Called from: getSessionDetails() inside SessionSelectionDialog

Field / Pattern                Description                                      Risk
Full session object returned   Dialog only uses the schedule field              MEDIUM
Nested therapist profile       Therapist likely included but never rendered     MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

6. GET /client/me/matches
File: matched_therapist_remote_data_source.dart
Called from: getMatches()

Field / Pattern               Description                                 Risk
No fields param passed        Full match objects returned by default      HIGH
Nested therapist profile      Full therapist profile inside each match    HIGH
Nested preference object      Preference linked to match included         MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

7. GET /client/me/notifications
File: notification_remote_data_source.dart
Called from: getNotifications()

Field / Pattern             Description                                Risk
No fields param             Full notification objects returned         LOW-MEDIUM
Nested reference objects    Linked sessions or chats may be expanded   MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

8. GET /client/me/diary
File: diary_remote_data_source.dart
Called from: getDiaryEntries()

Field / Pattern       Description                      Risk
No fields param       Full diary objects returned      LOW

------------------------------------------------------------------------------------------------------------------------------------------

9. GET /client
File: users_remote_data_source.dart
Called from: UsersListScreen via usersProvider

Field / Pattern                     Description                                             Risk
No fields param on method at all    No way to scope fields from the frontend currently      MEDIUM

------------------------------------------------------------------------------------------------------------------------------------------

10. GET /chat/{id}/messages
File: chat_remote_data_source.dart
Called from: getChatMessages()

Field / Pattern          Description                                                               Risk
No fields param          Full message objects returned by default                                  HIGH
Nested sender profile    Each message likely includes the full sender user object                  HIGH
Nested attachments       File/media objects may be fully expanded per message                      MEDIUM
Pagination not enforced  take param exists but no default — backend may return all messages        HIGH

------------------------------------------------------------------------------------------------------------------------------------------

11. GET /therapist/{id}
File: chat_remote_data_source.dart
Called from: getTherapistInfo()

Field / Pattern          Description                                             Risk
No fields param          Full therapist profile returned                         HIGH
Nested sessions          Therapist's session list may be included                HIGH
Nested reviews/ratings   Review objects likely expanded                          MEDIUM
Nested specializations   Could be an array of objects rather than flat strings   MEDIUM
Nested availability      Schedule/availability objects may be included           MEDIUM