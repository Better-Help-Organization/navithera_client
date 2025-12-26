// extra_questions_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:navithera_client/feature/questionnaire/data/datasources/extra_questions_data_source.dart';
import 'package:navithera_client/feature/questionnaire/data/repositories/extra_questions_impl.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/languages_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/levels_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/repositories/extra_questions_repository.dart';

enum ExtraQuestionStep {
  languages,
  levels,
  //  sessionFormat,
  availability,
  goals,
  gender,
}

final extraQuestionsStepProvider = StateProvider<ExtraQuestionStep>(
  (ref) => ExtraQuestionStep.languages,
);

final selectedLanguagesProvider = StateProvider<List<String>>((ref) => []);
final cleanedLanguageIdsProvider = Provider<List<String>>((ref) {
  final langs = ref.watch(selectedLanguagesProvider);
  return langs.where((id) => id != 'other').toList();
});
final selectedLevelProvider = StateProvider<String?>((ref) => null);
final selectedPrefProvider = StateProvider<String?>((ref) => null);
final selectedLevelPriceProvider = StateProvider<String?>((ref) => null);
final selectedGenderProvider = StateProvider<String?>((ref) => null);
//final selectedSessionFormatProvider = StateProvider<String?>((ref) => null);
final modalIdProvider = StateProvider<String?>((ref) => null);
final selectedAvailabilityProvider = StateProvider<List<Map<String, dynamic>>>(
  (ref) => [],
);
final otherLanguageProvider = StateProvider<String>((ref) => '');
//final otherLanguageProvider = StateProvider<String>((ref) => '');
final showOtherLanguageInputProvider = StateProvider<bool>((ref) => false);

final goalsProvider = StateProvider<String>((ref) => '');
// Repository Provider
final extraQuestionsRepositoryProvider = Provider<ExtraQuestionsRepository>((
  ref,
) {
  final dio = ref.read(dioProvider);
  final remoteDataSource = ExtraQuestionsDataSource(dio);
  return ExtraQuestionsImpl(remoteDataSource);
});

// Languages Provider
final languagesProvider =
    StateNotifierProvider<LanguagesNotifier, AsyncValue<LanguagesResponse>>((
      ref,
    ) {
      final repository = ref.read(extraQuestionsRepositoryProvider);
      return LanguagesNotifier(repository);
    });

// Levels Provider
final levelsProvider =
    StateNotifierProvider<LevelsNotifier, AsyncValue<LevelsResponse>>((ref) {
      final repository = ref.read(extraQuestionsRepositoryProvider);
      return LevelsNotifier(repository);
    });

//     final extraQuestionsRepositoryProvider = Provider<ExtraQuestionsRepository>((ref) {
//   final dio = ref.read(dioProvider);
//   final remoteDataSource = ExtraQuestionsDataSource(dio);
//   return ExtraQuestionsImpl(remoteDataSource);
// });

// Selected Languages Provider (array)
//final selectedLanguagesProvider = StateProvider<List<String>>((ref) => []);

// Selected Level Provider (single value)
// final selectedLevelProvider = StateProvider<String?>((ref) => null);

class LanguagesNotifier extends StateNotifier<AsyncValue<LanguagesResponse>> {
  final ExtraQuestionsRepository _repository;

  LanguagesNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadLanguages() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getLanguages();
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (languages) => state = AsyncValue.data(languages),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

class LevelsNotifier extends StateNotifier<AsyncValue<LevelsResponse>> {
  final ExtraQuestionsRepository _repository;

  LevelsNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadLevels() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getLevels();
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (levels) => state = AsyncValue.data(levels),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
