import 'cook_list_data_model.dart';

class CookClassificationLabels {
  const CookClassificationLabels({
    required this.servings,
    required this.servingsCount,
    required this.type,
    required this.genre,
    required this.genreHint,
    required this.starter,
    required this.main,
    required this.dessert,
    required this.aperitif,
    required this.drink,
  });

  final String servings;
  final String Function(int count) servingsCount;
  final String type;
  final String genre;
  final String genreHint;
  final String starter;
  final String main;
  final String dessert;
  final String aperitif;
  final String drink;

  String typeLabel(CookType type) => switch (type) {
    CookType.aperitif => aperitif,
    CookType.starter => starter,
    CookType.main => main,
    CookType.dessert => dessert,
    CookType.drink => drink,
  };
}

final _labels = {
  'fr': CookClassificationLabels(
    servings: 'Nombre de personnes',
    servingsCount: (n) => n == 1 ? '1 personne' : '$n personnes',
    type: 'Type',
    genre: 'Label',
    genreHint: 'Ajouter un label (ex. pizza, tarte…)',
    starter: 'Entrée',
    main: 'Plat',
    dessert: 'Dessert',
    aperitif: 'Apéritif',
    drink: 'Boisson',
  ),
  'en': CookClassificationLabels(
    servings: 'Number of people',
    servingsCount: (n) => n == 1 ? '1 person' : '$n people',
    type: 'Type',
    genre: 'Label',
    genreHint: 'Add a label (e.g. pizza, pie…)',
    starter: 'Starter',
    main: 'Main course',
    dessert: 'Dessert',
    aperitif: 'Appetizer',
    drink: 'Drink',
  ),
  'de': CookClassificationLabels(
    servings: 'Anzahl Personen',
    servingsCount: (n) => n == 1 ? '1 Person' : '$n Personen',
    type: 'Art',
    genre: 'Label',
    genreHint: 'Label hinzufügen (z. B. Pizza, Kuchen…)',
    starter: 'Vorspeise',
    main: 'Hauptgericht',
    dessert: 'Nachspeise',
    aperitif: 'Aperitif',
    drink: 'Getränk',
  ),
  'es': CookClassificationLabels(
    servings: 'Número de personas',
    servingsCount: (n) => n == 1 ? '1 persona' : '$n personas',
    type: 'Tipo',
    genre: 'Etiqueta',
    genreHint: 'Añadir etiqueta (ej. pizza, tarta…)',
    starter: 'Entrante',
    main: 'Plato principal',
    dessert: 'Postre',
    aperitif: 'Aperitivo',
    drink: 'Bebida',
  ),
  'it': CookClassificationLabels(
    servings: 'Numero di persone',
    servingsCount: (n) => n == 1 ? '1 persona' : '$n persone',
    type: 'Tipo',
    genre: 'Etichetta',
    genreHint: 'Aggiungi etichetta (es. pizza, torta…)',
    starter: 'Antipasto',
    main: 'Piatto principale',
    dessert: 'Dessert',
    aperitif: 'Aperitivo',
    drink: 'Bevanda',
  ),
};

CookClassificationLabels cookClassificationLabels(String languageCode) =>
    _labels[languageCode] ?? _labels['en']!;

const _genres = <String, Map<CookType, List<String>>>{
  'fr': {
    CookType.starter: [
      'salade',
      'soupe',
      'velouté',
      'terrine',
      'quiche',
      'tarte salée',
      'feuilleté',
      'carpaccio',
      'tartare',
      'oeufs mimosa',
    ],
    CookType.main: [
      'pizza',
      'pâtes bolognaise',
      'pâtes carbonara',
      'gratin',
      'lasagnes',
      'risotto',
      'curry',
      'poulet rôti',
      'steak frites',
      'poisson',
      'burger',
      'ragoût',
      'omelette',
      'quiche',
      'tajine',
    ],
    CookType.dessert: [
      'gâteau',
      'tarte',
      'salade de fruits',
      'mousse au chocolat',
      'crème dessert',
      'crêpes',
      'glace',
      'cookies',
      'clafoutis',
      'tiramisu',
      'brownie',
    ],
  },
  'en': {
    CookType.starter: [
      'salad',
      'soup',
      'terrine',
      'quiche',
      'savory tart',
      'carpaccio',
      'tartare',
      'deviled eggs',
    ],
    CookType.main: [
      'pizza',
      'spaghetti bolognese',
      'carbonara',
      'gratin',
      'lasagna',
      'risotto',
      'curry',
      'roast chicken',
      'steak and fries',
      'fish',
      'burger',
      'stew',
      'omelette',
      'tagine',
    ],
    CookType.dessert: [
      'cake',
      'pie',
      'fruit salad',
      'chocolate mousse',
      'pudding',
      'pancakes',
      'ice cream',
      'cookies',
      'clafoutis',
      'tiramisu',
      'brownie',
    ],
  },
  'de': {
    CookType.starter: ['Salat', 'Suppe', 'Terrine', 'Quiche', 'Carpaccio'],
    CookType.main: [
      'Pizza',
      'Spaghetti Bolognese',
      'Carbonara',
      'Auflauf',
      'Lasagne',
      'Risotto',
      'Curry',
      'Brathähnchen',
      'Fisch',
      'Burger',
      'Eintopf',
      'Omelett',
    ],
    CookType.dessert: [
      'Kuchen',
      'Torte',
      'Obstsalat',
      'Mousse au Chocolat',
      'Pudding',
      'Pfannkuchen',
      'Eis',
      'Kekse',
      'Tiramisu',
      'Brownie',
    ],
  },
  'es': {
    CookType.starter: [
      'ensalada',
      'sopa',
      'crema',
      'terrina',
      'quiche',
      'carpaccio',
    ],
    CookType.main: [
      'pizza',
      'pasta boloñesa',
      'carbonara',
      'gratinado',
      'lasaña',
      'risotto',
      'curry',
      'pollo asado',
      'pescado',
      'hamburguesa',
      'guiso',
      'tortilla',
      'tajín',
    ],
    CookType.dessert: [
      'pastel',
      'tarta',
      'macedonia',
      'mousse de chocolate',
      'flan',
      'crepes',
      'helado',
      'galletas',
      'tiramisú',
      'brownie',
    ],
  },
  'it': {
    CookType.starter: [
      'insalata',
      'zuppa',
      'vellutata',
      'terrina',
      'quiche',
      'carpaccio',
    ],
    CookType.main: [
      'pizza',
      'pasta alla bolognese',
      'carbonara',
      'gratin',
      'lasagne',
      'risotto',
      'curry',
      'pollo arrosto',
      'pesce',
      'hamburger',
      'stufato',
      'frittata',
    ],
    CookType.dessert: [
      'torta',
      'crostata',
      'macedonia',
      'mousse al cioccolato',
      'budino',
      'crêpes',
      'gelato',
      'biscotti',
      'tiramisù',
      'brownie',
    ],
  },
};

const _extraGenres = <String, Map<CookType, List<String>>>{
  'fr': {
    CookType.aperitif: [
      'toasts',
      'verrines',
      'feuilletés apéritifs',
      'houmous',
      'tapenade',
      'tapas',
      'mini-quiches',
    ],
    CookType.drink: [
      'cocktail',
      'smoothie',
      'jus de fruits',
      'limonade',
      'thé glacé',
      'chocolat chaud',
      'sangria',
    ],
  },
  'en': {
    CookType.aperitif: [
      'canapés',
      'dips',
      'finger food',
      'hummus',
      'tapenade',
      'tapas',
      'mini quiches',
    ],
    CookType.drink: [
      'cocktail',
      'smoothie',
      'fruit juice',
      'lemonade',
      'iced tea',
      'hot chocolate',
      'sangria',
    ],
  },
  'de': {
    CookType.aperitif: [
      'Canapés',
      'Dips',
      'Fingerfood',
      'Hummus',
      'Tapenade',
      'Tapas',
      'Mini-Quiches',
    ],
    CookType.drink: [
      'Cocktail',
      'Smoothie',
      'Fruchtsaft',
      'Limonade',
      'Eistee',
      'Heiße Schokolade',
      'Sangria',
    ],
  },
  'es': {
    CookType.aperitif: [
      'canapés',
      'tostas',
      'hummus',
      'tapenade',
      'tapas',
      'banderillas',
      'mini quiches',
    ],
    CookType.drink: [
      'cóctel',
      'batido',
      'zumo de frutas',
      'limonada',
      'té helado',
      'chocolate caliente',
      'sangría',
    ],
  },
  'it': {
    CookType.aperitif: [
      'crostini',
      'tartine',
      'finger food',
      'hummus',
      'tapenade',
      'stuzzichini',
      'mini quiche',
    ],
    CookType.drink: [
      'cocktail',
      'frullato',
      'succo di frutta',
      'limonata',
      'tè freddo',
      'cioccolata calda',
      'sangria',
    ],
  },
};

List<String> cookGenreSuggestions(String languageCode, CookType? type) {
  final byType = {
    ...(_genres[languageCode] ?? _genres['en']!),
    ...(_extraGenres[languageCode] ?? _extraGenres['en']!),
  };
  if (type != null) return byType[type] ?? const [];
  return {for (final list in byType.values) ...list}.toList();
}

/// Summary shown under the cooklist title, e.g. "Main course · pizza · 4 people".
String cookClassificationSummary(CookList cooklist, String languageCode) {
  final labels = cookClassificationLabels(languageCode);
  return [
    if (cooklist.type != null) labels.typeLabel(cooklist.type!),
    ...cooklist.labels,
    labels.servingsCount(cooklist.servings),
  ].join(' · ');
}
