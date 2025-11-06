import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/modals_response.dart';

abstract class ModalsRepository {
  Future<Either<Failure, ModalsResponse>> getModals({String? sort});
}
