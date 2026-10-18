// lib/features/icons/data/repositories/icon_repository_impl.dart
import '../../domain/entities/icon_entity.dart';
import '../../domain/repositories/icon_repository.dart';
import '../datasources/icon_local_data_source.dart';

class IconRepositoryImpl implements IconRepository {
  const IconRepositoryImpl(this._localDataSource);

  final IconLocalDataSource _localDataSource;

  @override
  Future<List<IconEntity>> getDynamicIcons() async {
    final models = await _localDataSource.fetchIcons();
    return models.map((model) => model.toEntity()).toList(growable: false);
  }
}
