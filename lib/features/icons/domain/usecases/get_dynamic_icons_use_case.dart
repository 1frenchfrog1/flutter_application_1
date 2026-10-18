// lib/features/icons/domain/usecases/get_dynamic_icons_use_case.dart
import '../entities/icon_entity.dart';
import '../repositories/icon_repository.dart';

class GetDynamicIconsUseCase {
  const GetDynamicIconsUseCase(this._repository);

  final IconRepository _repository;

  Future<List<IconEntity>> call() => _repository.getDynamicIcons();
}
