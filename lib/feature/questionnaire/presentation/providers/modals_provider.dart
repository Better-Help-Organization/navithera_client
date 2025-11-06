import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/modals_remote_data_source.dart';
import '../../data/repositories/modals_repository_impl.dart';
import '../../domain/entities/modals_response.dart';
import '../../domain/repositories/modals_repository.dart';

// Repository provider
final modalsRepositoryProvider = Provider<ModalsRepository>((ref) {
  final dio = ref.read(dioProvider);
  final remoteDataSource = ModalsRemoteDataSource(dio);
  return ModalsRepositoryImpl(remoteDataSource);
});

// Modals state provider
final modalsProvider =
    StateNotifierProvider<ModalsNotifier, AsyncValue<ModalsResponse>>((ref) {
      final repository = ref.read(modalsRepositoryProvider);
      return ModalsNotifier(repository);
    });

class ModalsNotifier extends StateNotifier<AsyncValue<ModalsResponse>> {
  final ModalsRepository _repository;

  ModalsNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadModals() async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.getModals();
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (modals) => state = AsyncValue.data(modals),
      );
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
