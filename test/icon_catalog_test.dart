import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/features/icons/data/datasources/icon_local_data_source.dart';
import 'package:flutter_application_1/features/icons/presentation/widgets/icon_glyph_registry.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('catalog contains unique, renderable, non-legacy icons', () async {
    final icons = await IconLocalDataSourceImpl().fetchIcons();
    const hugeGlyphs = {
      'strokeRoundedJoggerPants',
      'strokeRoundedShortsPants',
      'Robe',
      'strokeRoundedDress05',
      'Shoes',
      'strokeRoundedShoes',
      'strokeRoundedShirt01',
      'strokeRoundedHoodie',
      'strokeRoundedTissuePaper',
      'strokeRoundedCapRound',
    };

    expect(icons.map((icon) => icon.key).toSet(), hasLength(icons.length));
    expect(
      icons.where((icon) => icon.category == 'Météo').map((icon) => icon.key),
      containsAll([
        'meteo-soleil',
        'meteo-nuage',
        'meteo-pluie',
        'meteo-orage',
        'meteo-neige',
        'meteo-vent',
        'meteo-brouillard',
        'meteo-froid',
        'meteo-temperature',
      ]),
    );
    expect(
      icons.any(
        (icon) =>
            icon.key == 'vetements-sweatshirt' &&
            icon.label == 'Sweatshirt' &&
            icon.glyphName == 'strokeRoundedHoodie',
      ),
      isTrue,
    );
    expect(
      icons.where((icon) => icon.label.startsWith('Ancienne icône')),
      isEmpty,
    );
    expect(
      icons.where((icon) {
        if (icon.packageName == 'hugeicons') {
          return !hugeGlyphs.contains(icon.glyphName);
        }
        return !IconGlyphRegistry.iconData.containsKey(
          '${icon.packageName}|${icon.fontFamily}|${icon.glyphName}',
        );
      }),
      isEmpty,
    );
    expect(
      icons.where(
        (icon) =>
            icon.category == 'Loisirs' &&
            (icon.label == 'Ski' || icon.label == 'Golf'),
      ),
      hasLength(2),
    );
    expect(
      icons
          .where((icon) => icon.category == 'Loisirs')
          .map((icon) => icon.label),
      containsAll([
        'Tennis',
        'Marche',
        'Course à pied',
        'Natation',
        'Volley',
        'Cricket',
        'Rugby',
        'Baseball',
        'Hockey',
        'Handball',
        'Arts martiaux',
        'Gymnastique',
        'Football américain',
        'Sports mécaniques',
        'Surf',
        'Skateboard',
        'Snowboard',
        'Aviron',
        'Kayak',
        'Voile',
        'Randonnée',
        'Musculation',
        'Yoga',
        'Patinage',
      ]),
    );
  });

  test('catalog keys stay stable when labels and categories change', () async {
    final bundle = _JsonAssetBundle(
      '[{"key":"stable-icon-001","label":"Renamed label",'
      '"category":"New category","package":"material",'
      '"glyph":"0xe15b","fontFamily":"MaterialIcons"}]',
    );
    final icons = await IconLocalDataSourceImpl(assetBundle: bundle)
        .fetchIcons();

    expect(icons.single.key, 'stable-icon-001');
  });
}

class _JsonAssetBundle extends CachingAssetBundle {
  _JsonAssetBundle(this.contents);

  final String contents;

  @override
  Future<ByteData> load(String key) async {
    final bytes = Uint8List.fromList(utf8.encode(contents));
    return ByteData.sublistView(bytes);
  }
}
