import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../domain/entities/modals_response.dart';

part 'modals_remote_data_source.g.dart';

@RestApi()
abstract class ModalsRemoteDataSource {
  factory ModalsRemoteDataSource(Dio dio) = _ModalsRemoteDataSource;

  @GET('/modal')
  Future<ModalsResponse> getModals(@Query('sort') String? sort);
}
