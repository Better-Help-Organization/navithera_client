import 'package:dartz/dartz.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/languages_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/levels_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import '../../../../core/error/failures.dart';
// import '../entities/modals_response.dart';

abstract class ExtraQuestionsRepository {
  Future<Either<Failure, LanguagesResponse>> getLanguages();

  Future<Either<Failure, LevelsResponse>> getLevels();

  Future<Either<Failure, PreferenceResponse>> createPreference(
    PreferenceRequest request,
  );
  Future<Either<Failure, PreferenceResponse>> createPreferenceWithoutLevel(
    PreferenceRequestWithoutLevel request,
  );

  Future<Either<Failure, PreferenceGroupResponse>> createPreferenceForGroup(
    PreferenceRequestModalOnly request,
  );

  Future<Either<Failure, MatchResponse>> createMatch(MatchRequest request);
}
