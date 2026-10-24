// lib/features/icons/data/models/icon_model.dart
import '../../domain/entities/icon_entity.dart';

class IconModel {
  const IconModel({
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

  factory IconModel.fromJson(Map<String, dynamic> json) {
    final key = json['key'];
    if (key is! String || key.trim().isEmpty) {
      throw const FormatException('Each icon must have a non-empty "key".');
    }

    final label = json['label'];
    final packageName = json['package'];
    final glyphName = json['glyph'];
    final category = json['category'];
    final fontFamily = json['fontFamily'];
    if (label is! String || label.trim().isEmpty) {
      throw const FormatException('Each icon must have a non-empty "label".');
    }
    if (packageName is! String || packageName.trim().isEmpty) {
      throw const FormatException('Each icon must have a non-empty "package".');
    }
    if (glyphName is! String || glyphName.trim().isEmpty) {
      throw const FormatException('Each icon must have a non-empty "glyph".');
    }
    if (category != null && category is! String) {
      throw const FormatException('"category" must be a string.');
    }
    if (fontFamily != null && fontFamily is! String) {
      throw const FormatException('"fontFamily" must be a string.');
    }

    return IconModel(
      key: key.trim(),
      label: label.trim(),
      packageName: packageName.trim(),
      glyphName: glyphName.trim(),
      category: (category as String?)?.trim(),
      fontFamily: (fontFamily as String?)?.trim(),
    );
  }

  Map<String, dynamic> toJson() => {
    'key': key,
    'label': label,
    'package': packageName,
    'glyph': glyphName,
    if (category != null) 'category': category,
    if (fontFamily != null) 'fontFamily': fontFamily,
  };

  IconEntity toEntity() => IconEntity(
    key: key,
    label: label,
    packageName: packageName,
    glyphName: glyphName,
    category: category,
    fontFamily: fontFamily,
  );
}
