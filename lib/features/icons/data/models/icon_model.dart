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

  static String keyFor({
    required String category,
    required String label,
  }) {
    return '${_slug(category)}-${_slug(label)}';
  }

  static String _slug(String value) {
    var normalized = value.trim().toLowerCase();
    const replacements = {
      'à': 'a',
      'á': 'a',
      'â': 'a',
      'ä': 'a',
      'ã': 'a',
      'å': 'a',
      'ç': 'c',
      'è': 'e',
      'é': 'e',
      'ê': 'e',
      'ë': 'e',
      'ì': 'i',
      'í': 'i',
      'î': 'i',
      'ï': 'i',
      'ñ': 'n',
      'ò': 'o',
      'ó': 'o',
      'ô': 'o',
      'ö': 'o',
      'õ': 'o',
      'ù': 'u',
      'ú': 'u',
      'û': 'u',
      'ü': 'u',
      'ý': 'y',
      'ÿ': 'y',
      'œ': 'oe',
      'æ': 'ae',
      'ß': 'ss',
    };
    for (final entry in replacements.entries) {
      normalized = normalized.replaceAll(entry.key, entry.value);
    }
    return normalized
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  factory IconModel.fromEntity(IconEntity entity) => IconModel(
    key: entity.key,
    label: entity.label,
    packageName: entity.packageName,
    glyphName: entity.glyphName,
    category: entity.category,
    fontFamily: entity.fontFamily,
  );

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
