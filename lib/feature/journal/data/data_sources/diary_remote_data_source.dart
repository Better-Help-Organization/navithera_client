import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/network/dio_client.dart';
import 'package:retrofit/retrofit.dart';
import '../models/diary_models.dart';

part 'diary_remote_data_source.g.dart';

@RestApi()
abstract class DiaryRemoteDataSource {
  factory DiaryRemoteDataSource(Dio dio) = _DiaryRemoteDataSource;

  @GET('/client/me/diary')
  Future<DiaryListResponse> getDiaryEntries({
    @Query('page') int? page,
    @Query('take') int? take,
    @Query('sort') String? sort,
  });

  @POST('/diary')
  Future<DiaryCreateResponse> createDiaryEntry(
    @Body() Map<String, dynamic> request,
  );

  @PATCH('/diary/{id}')
  Future<DiaryEditResponse> updateDiaryEntry(
    @Path('id') String id,
    @Body() Map<String, dynamic> request,
  );

  @DELETE('/diary/{id}')
  Future<DiaryEditResponse> deleteDiaryEntry(@Path('id') String id);
}

final diaryRemoteDataSourceProvider = Provider<DiaryRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return DiaryRemoteDataSource(dio);
});
