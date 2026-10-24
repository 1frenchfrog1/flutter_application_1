// lib/features/icons/data/datasources/icon_local_data_source.dart
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/icon_model.dart';

abstract interface class IconLocalDataSource {
  Future<List<IconModel>> fetchIcons();
}

class IconLocalDataSourceImpl implements IconLocalDataSource {
  IconLocalDataSourceImpl({
    AssetBundle? assetBundle,
    this.assetPath = 'assets/icons/icon_catalog.json',
  }) : _assetBundle = assetBundle ?? rootBundle;

  final AssetBundle _assetBundle;
  final String assetPath;

  @override
  Future<List<IconModel>> fetchIcons() async {
    final jsonString = await _assetBundle.loadString(assetPath);
    final decoded = jsonDecode(jsonString);
    if (decoded is! List) {
      throw const FormatException('The icon catalog must be a JSON array.');
    }

    final icons = decoded.map((item) {
      if (item is! Map) {
        throw const FormatException('Each icon must be a JSON object.');
      }
      return IconModel.fromJson(Map<String, dynamic>.from(item));
    }).toList(growable: false);

    final keys = icons.map((icon) => icon.key).toSet();
    if (keys.length != icons.length) {
      throw const FormatException('Icon keys in the catalog must be unique.');
    }

    for (final icon in icons) {
      final category = icon.category;
      if (category == null || category.isEmpty) {
        throw const FormatException(
          'Each catalog icon must have a non-empty "category".',
        );
      }
    }

    return icons;
  }
}
