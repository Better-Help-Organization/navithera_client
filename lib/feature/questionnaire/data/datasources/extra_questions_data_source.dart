//extra_questions_data_sources.dart
import 'package:dio/dio.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/languages_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/levels_response.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:retrofit/retrofit.dart';

part 'extra_questions_data_source.g.dart';

@RestApi()
abstract class ExtraQuestionsDataSource {
  factory ExtraQuestionsDataSource(Dio dio) = _ExtraQuestionsDataSource;

  @GET('/language')
  Future<LanguagesResponse> getLanguages();

  @GET('/level')
  Future<LevelsResponse> getLevel();

  @POST('/preference')
  Future<PreferenceResponse> createPreference(
    @Body() PreferenceRequest request,
  );

  @POST('/preference')
  Future<PreferenceResponse> createPreferenceWithoutLevel(
    @Body() PreferenceRequestWithoutLevel request,
  );

  @POST('/preference')
  Future<PreferenceGroupResponse> createPreferenceForGroup(
    @Body() PreferenceRequestModalOnly request,
  );

  @POST('/match')
  Future<MatchResponse> createMatch(@Body() MatchRequest request);

  @PATCH('/preference/{id}')
  Future<PreferenceResponse> updatePreference(
    @Path('id') String preferenceId,
    @Body() PreferenceUpdateRequest request,
  );

  @PATCH('/preference/{id}')
  Future<PreferenceResponse> updatePreferenceWithoutLevel(
    @Path('id') String preferenceId,
    @Body() PreferenceUpdateWithoutLevelRequest request,
  );
}
