import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:navithera_client/core/util/format_duration.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navithera_client/feature/chat/presentation/providers/search_chat_provider.dart';

class ChatSearchScreen extends ConsumerStatefulWidget {
  const ChatSearchScreen({super.key});

  @override
  ConsumerState<ChatSearchScreen> createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends ConsumerState<ChatSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(searchChatProvider);
      if (state is SearchLoaded && state.canLoadMore) {
        ref
            .read(searchChatProvider.notifier)
            .searchChats(_searchController.text, loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchChatProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: const InputDecoration(
            hintText: 'Search chats...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            ref.read(searchChatProvider.notifier).searchChats(value);
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                ref.read(searchChatProvider.notifier).clearSearch();
              },
            ),
        ],
      ),
      body: _buildBody(searchState),
    );
  }

  Widget _buildBody(SearchChatState searchState) {
    final router = ref.read(routerProvider);
    return switch (searchState) {
      SearchInitial() => const Center(
        child: Text('Start typing to search chats'),
      ),
      SearchLoading() => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      SearchError(:final failure) => Center(
        child: Text('Error: ${failure.message}'),
      ),
      SearchEmpty() => const Center(child: Text('No chats found')),
      SearchLoaded(:final threads, :final canLoadMore) => ListView.builder(
        controller: _scrollController,
        itemCount: threads.length + (canLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == threads.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }

          final thread = threads[index];
          final therapist = thread.therapist;
          final client = thread.client;
          final lastMessage = thread.lastMessage?.content;
          final updatedAt = thread.updatedAt;
          final displayTime =
              updatedAt != null ? formatTelegramStyle(updatedAt) : '';

          return ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape:
                    thread.group.isNotEmpty
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                borderRadius:
                    thread.group.isNotEmpty ? BorderRadius.circular(12) : null,
                gradient: LinearGradient(
                  colors: getRandomGradient(),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  initials(
                    thread.group.isEmpty
                        ? '${therapist.firstName} ${therapist.lastName}'
                        : 'Group',
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title:
                thread.group.isEmpty
                    ? Text('${therapist.firstName} ${therapist.lastName}')
                    : Text('Group Chat #${thread.id.substring(0, 8)}'),
            subtitle: Text(
              lastMessage ?? 'No messages yet',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing:
                lastMessage != null
                    ? Text(
                      displayTime,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                    : null,
            onTap: () {
              final chat = Chat(
                id: thread.id,
                name:
                    therapist != null
                        ? '${therapist.firstName} ${therapist.lastName}'
                        : "Group Chat",
                lastMessage: 'I sent you the design files 📎',
                avatarUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
                unreadCount: 0,
                timestamp: DateTime(2025, 4, 2, 14, 15),
                isOutgoing: true,
                isRead: true,
                isGroup: thread.group.isNotEmpty,
                groupList: thread.group,
                user: therapist,
              );
              router.push('/chat/${thread.id}', extra: chat);
              // Navigate to chat screen
              // You can reuse your existing chat navigation logic
            },
          );
        },
      ),
      // TODO: Handle this case.
      SearchChatState() => throw UnimplementedError(),
    };
  }
}
