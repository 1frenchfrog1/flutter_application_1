import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/features/icons/data/datasources/icon_local_data_source.dart';
import 'package:flutter_application_1/features/icons/data/models/icon_model.dart';
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
    };

    expect(icons.map((icon) => icon.key).toSet(), hasLength(icons.length));
    expect(
      icons.every(
        (icon) =>
            icon.key ==
            IconModel.keyFor(category: icon.category!, label: icon.label),
      ),
      isTrue,
      reason: 'Icon keys must only depend on category and label.',
    );
    expect(
      icons.map((icon) => '${icon.category}|${icon.label}').toSet(),
      hasLength(icons.length),
      reason: 'Each category and label pair must be unique.',
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
}
