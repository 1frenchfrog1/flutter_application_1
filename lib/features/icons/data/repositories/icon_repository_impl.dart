// lib/features/icons/data/repositories/icon_repository_impl.dart
import '../../domain/entities/icon_entity.dart';
import '../../domain/repositories/icon_repository.dart';
import '../datasources/icon_local_data_source.dart';

class IconRepositoryImpl implements IconRepository {
  IconRepositoryImpl(this._localDataSource);

  final IconLocalDataSource _localDataSource;
  Future<List<IconEntity>>? _iconsFuture;

  @override
  Future<List<IconEntity>> getDynamicIcons() {
    final cached = _iconsFuture;
    if (cached != null) return cached;

    final future = _loadIcons().catchError((
      Object error,
      StackTrace stackTrace,
    ) {
      _iconsFuture = null;
      Error.throwWithStackTrace(error, stackTrace);
    });
    _iconsFuture = future;
    return future;
  }

  Future<List<IconEntity>> _loadIcons() async {
    final models = await _localDataSource.fetchIcons();
    return models.map((model) => model.toEntity()).toList(growable: false);
  }
}
