// lib/features/icons/presentation/widgets/dynamic_icon_view.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../domain/entities/icon_entity.dart';
import 'icon_glyph_registry.dart';

class DynamicIconView extends StatelessWidget {
  const DynamicIconView({required this.icon, this.size = 32, super.key});

  final IconEntity icon;
  final double size;

  static const Map<String, List<List<dynamic>>> _hugeIcons = {
    'strokeRoundedJoggerPants': HugeIcons.strokeRoundedJoggerPants,
    'strokeRoundedShortsPants': HugeIcons.strokeRoundedShortsPants,
    'Robe': HugeIcons.strokeRoundedDress05,
    'strokeRoundedDress05': HugeIcons.strokeRoundedDress05,
    'Shoes': HugeIcons.strokeRoundedShoes,
    'strokeRoundedShoes': HugeIcons.strokeRoundedShoes,
    'strokeRoundedShirt01': HugeIcons.strokeRoundedShirt01,
  };

  @override
  Widget build(BuildContext context) {
    if (icon.packageName == 'hugeicons') {
      final hugeIcon = _hugeIcons[icon.glyphName];
      if (hugeIcon != null) {
        return HugeIcon(icon: hugeIcon, size: size);
      }
    }

    final data = IconGlyphRegistry.iconData[
      '${icon.packageName}|${icon.fontFamily}|${icon.glyphName}'
    ];
    if (data != null) {
      if (icon.packageName == 'font_awesome_flutter') {
        return FaIcon(FaIconData(data), size: size);
      }
      return Icon(data, size: size);
    }

    final rendererKey = '${icon.packageName}:${icon.glyphName}';
    return Tooltip(
      message: 'Icône non configurée : $rendererKey',
      child: Icon(Icons.help_outline, size: size),
    );
  }

}
