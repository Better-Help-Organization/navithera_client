import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/journal/data/models/diary_models.dart';
// import 'package:navithera_client/feature/diary/data/models/diary_models.dart';
// import 'package:navithera_client/feature/diary/presentation/providers/diary_provider.dart';
import 'package:navithera_client/feature/journal/presentation/pages/add_edit_journal.dart';
import "package:flutter_gen/gen_l10n/app_localization.dart";
import 'package:navithera_client/feature/journal/presentation/providers/diary_provider.dart';

class MyJournalScreen extends ConsumerStatefulWidget {
  @override
  _MyJournalScreenState createState() => _MyJournalScreenState();
}

class _MyJournalScreenState extends ConsumerState<MyJournalScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDiaryEntries();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadDiaryEntries({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      await ref
          .read(diaryProvider.notifier)
          .getDiaryEntries(loadMore: loadMore, silent: silent);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load diary entries'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(diaryProvider);
      if (state is Loaded && state.canLoadMore) {
        _loadDiaryEntries(loadMore: true, silent: true);
      }
    }
  }

  Future<void> _handleRefresh() async {
    await _loadDiaryEntries(silent: true);
  }

  void _navigateToAddEntry() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditJournalScreen()),
    );

    if (result != null && result is Map<String, String>) {
      ref
          .read(diaryProvider.notifier)
          .createDiaryEntry(
            title: result['title']!,
            content: result['content']!,
          );
    }
  }

  void _navigateToEditEntry(DiaryEntry entry) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditJournalScreen(entry: entry),
      ),
    );

    if (result != null && result is Map<String, String>) {
      ref
          .read(diaryProvider.notifier)
          .updateDiaryEntry(
            id: entry.id,
            title: result['title']!,
            content: result['content']!,
          );
    }
  }

  void _deleteEntry(String id) {
    ref.read(diaryProvider.notifier).deleteDiaryEntry(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Journal entry deleted'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showDeleteDialog(DiaryEntry entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Delete Entry'),
          content: Text('Are you sure you want to delete "${entry.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).maybePop();
                _deleteEntry(entry.id);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final diaryState = ref.watch(diaryProvider);
    final router = ref.watch(routerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => router.go("/main"),
        ),
        title: Text(
          AppLocalizations.of(context)!.myJournal,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(diaryState),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddEntry,
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.add, color: Colors.white, size: 28),
        shape: CircleBorder(),
      ),
    );
  }

  // Widget _buildBody(DiaryState diaryState) {
  //   return switch (diaryState) {
  //     Initial() => RefreshIndicator(
  //       onRefresh: _handleRefresh,
  //       color: AppColors.primary,
  //       child: const Center(child: Text('No diary entries available')),
  //     ),
  //     Loading() => const Center(
  //       child: CircularProgressIndicator(color: AppColors.primary),
  //     ),
  //     Error(:final failure) => RefreshIndicator(
  //       onRefresh: _handleRefresh,
  //       color: AppColors.primary,
  //       child: SingleChildScrollView(
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         child: SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.8,
  //           child: Center(child: Text(failure.toString())),
  //         ),
  //       ),
  //     ),
  //     Loaded(:final entries, :final canLoadMore) => RefreshIndicator(
  //       onRefresh: _handleRefresh,
  //       color: AppColors.primary,
  //       child: ListView.builder(
  //         controller: _scrollController,
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         itemCount: entries.length + (canLoadMore ? 1 : 0),
  //         itemBuilder: (context, index) {
  //           if (index == entries.length) {
  //             return const Padding(
  //               padding: EdgeInsets.symmetric(vertical: 16.0),
  //               child: Center(
  //                 child: CircularProgressIndicator(color: AppColors.primary),
  //               ),
  //             );
  //           }

  //           final entry = entries[index];
  //           // final isYellow = index % 2 == 0;

  //           return Container(
  //             margin: EdgeInsets.only(bottom: 12),
  //             child: Card(
  //               color: AppColors.primary,
  //               elevation: 2,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //               child: InkWell(
  //                 onTap: () => _navigateToEditEntry(entry),
  //                 borderRadius: BorderRadius.circular(12),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(16),
  //                   child: Row(
  //                     children: [
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               entry.title,
  //                               style: TextStyle(
  //                                 fontSize: 18,
  //                                 fontWeight: FontWeight.w600,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                             SizedBox(height: 4),
  //                             Text(
  //                               entry.content,
  //                               style: TextStyle(
  //                                 fontSize: 14,
  //                                 color: Colors.white,
  //                               ),
  //                               maxLines: 2,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             SizedBox(height: 8),
  //                             Text(
  //                               _formatDate(entry.createdAt),
  //                               style: TextStyle(
  //                                 fontSize: 12,
  //                                 color: Colors.black45,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       IconButton(
  //                         icon: Icon(
  //                           Icons.delete_outline,
  //                           color: Colors.black54,
  //                           size: 20,
  //                         ),
  //                         onPressed: () => _showDeleteDialog(entry),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //     DiaryState() => throw UnimplementedError(),
  //   };
  // }

  Widget _buildBody(DiaryState diaryState) {
    return diaryState.when(
      initial:
          () => RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: const Center(child: Text('No diary entries available')),
          ),
      loading:
          () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
      error:
          (failure) => RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Center(child: Text(failure.toString())),
              ),
            ),
          ),
      loaded:
          (entries, pagination, canLoadMore) => RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primary,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: entries.length + (canLoadMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == entries.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }

                final entry = entries[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: Card(
                    color: AppColors.primary,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _navigateToEditEntry(entry),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    entry.content,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    _formatDate(entry.createdAt),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.black54,
                                size: 20,
                              ),
                              onPressed: () => _showDeleteDialog(entry),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      // Add these if you have operation states in your DiaryState
      operationLoading:
          (operationType) => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
      operationSuccess:
          (message) => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
    );
  }
}
