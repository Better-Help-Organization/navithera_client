import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/modals_response.dart';
import '../../domain/repositories/modals_repository.dart';
import '../datasources/modals_remote_data_source.dart';

class ModalsRepositoryImpl implements ModalsRepository {
  final ModalsRemoteDataSource remoteDataSource;

  ModalsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ModalsResponse>> getModals({String? sort}) async {
    try {
      final result = await remoteDataSource.getModals('order=asc');
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
