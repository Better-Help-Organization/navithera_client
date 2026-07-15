import 'package:dio/dio.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/submit_answers_request.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/entities/questions_response.dart';

part 'questions_remote_data_source.g.dart';

@RestApi()
abstract class QuestionsRemoteDataSource {
  factory QuestionsRemoteDataSource(Dio dio) = _QuestionsRemoteDataSource;

  @GET('/question')
  Future<QuestionsResponse> getQuestions({
    @Query('fields') String fields = 'text,type,createdAt,modal.id,option.*',
    @Query('take') int take = 0,
    @Query('filters') String? filters, // Add filters parameter
    @Query('sort') String sort = 'order=asc',
  });

  @POST('/answer')
  Future<void> submitAnswers({@Body() required SubmitAnswersRequest request});
}
