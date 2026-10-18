// lib/features/icons/domain/repositories/icon_repository.dart
import '../entities/icon_entity.dart';

abstract interface class IconRepository {
  Future<List<IconEntity>> getDynamicIcons();
}
