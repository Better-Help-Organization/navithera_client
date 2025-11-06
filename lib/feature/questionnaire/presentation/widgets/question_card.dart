import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';
import '../providers/questions_provider.dart';

class QuestionCard extends ConsumerStatefulWidget {
  final Question question;
  final VoidCallback? onAnswered;

  const QuestionCard({super.key, required this.question, this.onAnswered});

  @override
  ConsumerState<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _otherTextController = TextEditingController();

  bool _showOtherInput = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();

    // // Load existing answer if any
    // final existingAnswer = ref
    //     .read(userAnswersProvider.notifier)
    //     .getAnswerForQuestion(widget.question.id);
    // if (existingAnswer?.text != null) {
    //   _textController.text = existingAnswer!.text!;
    // }
    final existingAnswer = ref
        .read(userAnswersProvider.notifier)
        .getAnswerForQuestion(widget.question.id);

    if (existingAnswer?.text != null) {
      _otherTextController.text = existingAnswer!.text!;
      _showOtherInput = true;
    }

    // Check if "Other" option is selected in current answer
    _checkIfOtherIsSelected(existingAnswer);
  }

  void _checkIfOtherIsSelected(UserAnswer? currentAnswer) {
    if (currentAnswer == null) {
      _showOtherInput = false;
      return;
    }

    // Get the "Other" option
    final otherOption = _getOtherOption();

    if (otherOption != null) {
      if (widget.question.type == 'single') {
        _showOtherInput = currentAnswer.selectedOptionId == otherOption.id;
      } else if (widget.question.type == 'multiple') {
        _showOtherInput =
            currentAnswer.selectedOptionIds?.contains(otherOption.id) ?? false;
      }
    }
  }

  QuestionOption? _getOtherOption() {
    try {
      return widget.question.option.firstWhere(
        (option) => option.text.toLowerCase().contains('other'),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAnswers = ref.watch(userAnswersProvider);
    final currentAnswer =
        userAnswers
            .where((answer) => answer.questionId == widget.question.id)
            .firstOrNull;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.question.text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                      height: 1.3,
                    ),
                  ),
                  if (widget.question.type == 'multiple')
                    //const SizedBox(height: 24),
                    Column(
                      children: [
                        const SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(top: 4, bottom: 12),
                          child: Text(
                            'Select multiple options that apply',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  if (widget.question.type == 'single')
                    _buildSingleChoiceOptions(currentAnswer)
                  else if (widget.question.type == 'multiple')
                    _buildMultipleChoiceOptions(currentAnswer)
                  else if (widget.question.type == 'open')
                    _buildOpenEndedInput(currentAnswer),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMultipleChoiceOptions(dynamic currentAnswer) {
    final otherOption = _getOtherOption();
    final sortedOptions = _getSortedOptions(widget.question.option);

    return Column(
      children:
          sortedOptions.map((option) {
            final isSelected =
                currentAnswer?.selectedOptionIds?.contains(option.id) ?? false;
            final isOtherOption = option.id == otherOption?.id;

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _toggleMultipleOption(option),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? const Color(0xFF7EB09B).withOpacity(0.1)
                                  : const Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color(0xFF7EB09B)
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:
                                    isSelected
                                        ? const Color(0xFF7EB09B)
                                        : Colors.transparent,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? const Color(0xFF7EB09B)
                                          : const Color(0xFFCBD5E0),
                                  width: 2,
                                ),
                              ),
                              child:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      )
                                      : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                option.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSelected
                                          ? const Color(0xFF7EB09B)
                                          : const Color(0xFF4A5568),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Show other input if this is the "Other" option and it's selected
                if (isOtherOption && isSelected) _buildOtherInputField(),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildOtherInputField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 0, right: 0),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _otherTextController,
        onChanged: (value) => _updateOtherText(value),
        decoration: const InputDecoration(
          hintText: 'Please specify...',
          hintStyle: TextStyle(color: Color(0xFFA0AEC0), fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
        style: const TextStyle(fontSize: 14, color: Color(0xFF2D3748)),
      ),
    );
  }

  void _updateOtherText(String text) {
    final currentAnswer = ref
        .read(userAnswersProvider.notifier)
        .getAnswerForQuestion(widget.question.id);

    if (currentAnswer != null) {
      ref
          .read(userAnswersProvider.notifier)
          .updateAnswer(
            widget.question.id,
            selectedOptionId: currentAnswer.selectedOptionId,
            selectedOptionIds: currentAnswer.selectedOptionIds,
            text: text,
          );
    }
  }

  // List<QuestionOption> _getSortedOptions(List<QuestionOption> options) {
  //   // Create a copy to avoid modifying the original list
  //   final sortedOptions = List<QuestionOption>.from(options);

  //   // Sort by order in ascending order
  //   sortedOptions.sort((a, b) => a.order.compareTo(b.order));

  //   return sortedOptions;
  // }
  List<QuestionOption> _getSortedOptions(List<QuestionOption> options) {
    // Create a copy to avoid modifying the original list
    final sortedOptions = List<QuestionOption>.from(options);

    // Sort by order in ascending order, handling null values
    sortedOptions.sort((a, b) {
      // Handle null values - treat null as higher order (appear last)
      if (a.order == null && b.order == null) return 0;
      if (a.order == null) return 1; // a should come after b
      if (b.order == null) return -1; // a should come before b

      // Both are non-null, compare normally
      return a.order!.compareTo(b.order!);
    });

    return sortedOptions;
  }

  Widget _buildSingleChoiceOptions(dynamic currentAnswer) {
    final otherOption = _getOtherOption();
    final sortedOptions = _getSortedOptions(widget.question.option);

    return Column(
      children:
          sortedOptions.map((option) {
            final isSelected = currentAnswer?.selectedOptionId == option.id;
            final isOtherOption = option.id == otherOption?.id;

            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _selectOption(option),
                      borderRadius: BorderRadius.circular(12),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? const Color(0xFF7EB09B).withOpacity(0.1)
                                  : const Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? const Color(0xFF7EB09B)
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isSelected
                                        ? const Color(0xFF7EB09B)
                                        : Colors.transparent,
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? const Color(0xFF7EB09B)
                                          : const Color(0xFFCBD5E0),
                                  width: 2,
                                ),
                              ),
                              child:
                                  isSelected
                                      ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      )
                                      : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                option.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSelected
                                          ? const Color(0xFF7EB09B)
                                          : const Color(0xFF4A5568),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Show other input if this is the "Other" option and it's selected
                if (isOtherOption && isSelected) _buildOtherInputField(),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildOpenEndedInput(dynamic currentAnswer) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _textController,
        maxLines: 4,
        onChanged: (value) => _updateTextAnswer(value),
        decoration: const InputDecoration(
          hintText: 'Share your thoughts...',
          hintStyle: TextStyle(color: Color(0xFFA0AEC0), fontSize: 16),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF2D3748),
          height: 1.5,
        ),
      ),
    );
  }

  // void _selectOption(QuestionOption option) {
  //   ref
  //       .read(userAnswersProvider.notifier)
  //       .updateAnswer(widget.question.id, selectedOptionId: option.id);
  //   widget.onAnswered?.call();
  // }
  void _selectOption(QuestionOption option) {
    final otherOption = _getOtherOption();
    final isOtherOption = option.id == otherOption?.id;

    String? text = isOtherOption ? _otherTextController.text : null;

    ref
        .read(userAnswersProvider.notifier)
        .updateAnswer(
          widget.question.id,
          selectedOptionId: option.id,
          text: text,
        );

    setState(() {
      _showOtherInput = isOtherOption;
    });

    if (!isOtherOption) widget.onAnswered?.call();
  }

  void _toggleMultipleOption(QuestionOption option) {
    final otherOption = _getOtherOption();
    final isOtherOption = option.id == otherOption?.id;
    final currentAnswer = ref
        .read(userAnswersProvider.notifier)
        .getAnswerForQuestion(widget.question.id);

    final currentIds = currentAnswer?.selectedOptionIds ?? [];
    final newIds =
        currentIds.contains(option.id)
            ? currentIds.where((id) => id != option.id).toList()
            : [...currentIds, option.id];

    // If "Other" is being deselected, clear the text
    String? text = currentAnswer?.text;
    if (isOtherOption && !newIds.contains(option.id)) {
      text = null;
      _otherTextController.clear();
    } else if (isOtherOption && newIds.contains(option.id)) {
      text = _otherTextController.text;
    }

    ref
        .read(userAnswersProvider.notifier)
        .updateAnswer(
          widget.question.id,
          selectedOptionIds: newIds.isNotEmpty ? newIds : null,
          text: text,
        );

    setState(() {
      _showOtherInput = isOtherOption && newIds.contains(option.id);
    });

    // Don't call onAnswered for multiple choice - no auto-swipe
  }

  void _updateTextAnswer(String text) {
    if (text.trim().isNotEmpty) {
      ref
          .read(userAnswersProvider.notifier)
          .updateAnswer(widget.question.id, text: text);
      //widget.onAnswered?.call();
    }
  }
}
