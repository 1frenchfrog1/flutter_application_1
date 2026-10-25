const cookingIconCategory = 'Cuisine';

const _cookingCategoryLabels = {
  'fr': 'Cuisine',
  'en': 'Cooking',
  'de': 'Küche',
  'es': 'Cocina',
  'it': 'Cucina',
};

String localizeCookingCategory(String languageCode) =>
    _cookingCategoryLabels[languageCode] ?? _cookingCategoryLabels['en']!;
