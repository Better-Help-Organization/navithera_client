import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
//import 'package:navithera_client/feature/diary/data/models/diary_models.dart';
import "package:navithera_client/l10n/app_localizations.dart";
import 'package:navithera_client/feature/journal/data/models/diary_models.dart';
import 'package:navithera_client/feature/journal/presentation/providers/diary_provider.dart';

class AddEditJournalScreen extends ConsumerStatefulWidget {
  final DiaryEntry? entry;

  AddEditJournalScreen({this.entry});

  @override
  _AddEditJournalScreenState createState() => _AddEditJournalScreenState();
}

class _AddEditJournalScreenState extends ConsumerState<AddEditJournalScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool get isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _titleController.text = widget.entry!.title;
      _contentController.text = widget.entry!.content;
    } else {
      _contentController.text = '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    if (_formKey.currentState!.validate() && !_isLoading) {
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();

      if (isEditing) {
        ref
            .read(diaryProvider.notifier)
            .updateDiaryEntry(
              id: widget.entry!.id,
              title: title,
              content: content,
            );
      } else {
        ref
            .read(diaryProvider.notifier)
            .createDiaryEntry(title: title, content: content);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DiaryState>(diaryProvider, (previous, next) {
      final router = ref.read(routerProvider);
      next.whenOrNull(
        operationSuccess: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.green),
          );
          router.go("/journal");
          Navigator.maybePop(context);
        },
        error: (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message.toString()),
              backgroundColor: Colors.red,
            ),
          );
          setState(() => _isLoading = false);
        },
      );
    });

    final diaryState = ref.watch(diaryProvider);
    _isLoading = diaryState is OperationLoading;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: _isLoading ? null : () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Entry' : AppLocalizations.of(context)!.todaysMusing,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveEntry,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // ... rest of your form fields
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterTitle,
                          hintStyle: TextStyle(color: Colors.black38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      Expanded(
                        child: TextFormField(
                          controller: _contentController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.letItPour,
                            hintStyle: TextStyle(color: Colors.black38),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter some content';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveEntry,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                          ),
                          child:
                              _isLoading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    isEditing
                                        ? 'Update Note'
                                        : AppLocalizations.of(
                                          context,
                                        )!.saveNote,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
