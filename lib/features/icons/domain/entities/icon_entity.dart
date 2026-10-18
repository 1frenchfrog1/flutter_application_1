// lib/features/icons/domain/entities/icon_entity.dart
import 'package:equatable/equatable.dart';

class IconEntity extends Equatable {
  const IconEntity({
    required this.key,
    required this.label,
    required this.packageName,
    required this.glyphName,
    this.category,
    this.fontFamily,
  });

  final String key;
  final String label;
  final String packageName;
  final String glyphName;
  final String? category;
  final String? fontFamily;

  @override
  List<Object?> get props => [
    key,
    label,
    packageName,
    glyphName,
    category,
    fontFamily,
  ];
}
