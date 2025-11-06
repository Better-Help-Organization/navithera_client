// group_chat_creation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navithera_client/feature/chat/presentation/pages/message_screen.dart';
//import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import 'package:navithera_client/feature/therapy/presentation/providers/users_provider.dart';
//import '../providers/users_provider.dart';

class GroupChatCreationScreen extends ConsumerStatefulWidget {
  const GroupChatCreationScreen({super.key});

  @override
  ConsumerState<GroupChatCreationScreen> createState() =>
      _GroupChatCreationScreenState();
}

class _GroupChatCreationScreenState
    extends ConsumerState<GroupChatCreationScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<UserModel> _selectedUsers = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).getUsers();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(usersProvider);
      if (state is Loaded && state.canLoadMore) {
        ref.read(usersProvider.notifier).getUsers(loadMore: true);
      }
    }
  }

  void _toggleUserSelection(UserModel user) {
    setState(() {
      if (_selectedUsers.contains(user)) {
        _selectedUsers.remove(user);
      } else {
        _selectedUsers.add(user);
      }
    });
  }

  Future<void> _createGroupChat() async {
    if (_selectedUsers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one user'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get current user'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => const Center(
              child: CircularProgressIndicator(color: Color(0xFF7EB09B)),
            ),
      );

      final chatRepository = ref.read(chatRepositoryProvider);
      final result = await chatRepository.createGroupChat(
        clientIds: _selectedUsers.map((user) => user.id).toList(),
        therapistId: currentUser.id,
      );

      Navigator.of(context).pop();

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create group chat: ${failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (response) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChatMessageScreen(
                    chat: Chat(
                      id: response.data.id,
                      name: "Group Chat",
                      lastMessage: 'Group created',
                      avatarUrl: '',
                      unreadCount: 0,
                      timestamp: DateTime.now(),
                      isOutgoing: true,
                      isRead: true,
                      isGroup: true,
                    ),
                  ),
            ),
          );
        },
      );
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating group chat: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _createGroupChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // Selected users section
          if (_selectedUsers.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedUsers.length,
                itemBuilder: (context, index) {
                  final user = _selectedUsers[index];
                  final initials =
                      '${user.firstName.substring(0, 1)}${user.lastName.substring(0, 1)}'
                          .toUpperCase();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          child: Text(initials),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.firstName,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          // All users list
          Expanded(
            child: switch (usersState) {
              Initial() => const Center(child: Text('No users available')),
              Loading() => const Center(child: CircularProgressIndicator()),
              Error(:final failure) => Center(
                child: Text('Error: ${failure.message}'),
              ),
              Loaded(:final users, :final canLoadMore) => ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                // itemCount: users.length,
                itemCount: users.length + (canLoadMore ? 1 : 0),
                //   separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index == users.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF7EB09B),
                          ),
                        ),
                      ),
                    );
                  }
                  final user = users[index];
                  final isSelected = _selectedUsers.contains(user);
                  final initials =
                      '${user.firstName?.substring(0, 1) ?? ''}${user.lastName?.substring(0, 1) ?? ''}'
                          .toUpperCase();
                  final userName =
                      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          isSelected
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.1),
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.primary,
                        ),
                      ),
                    ),
                    title: Text(userName),
                    subtitle: Text(user.email ?? ''),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isSelected ? AppColors.primary : Colors.grey,
                    ),
                    onTap: () => _toggleUserSelection(user),
                  );
                },
              ),
              // TODO: Handle this case.
              UsersState() => throw UnimplementedError(),
            },
          ),
        ],
      ),
    );
  }
}
