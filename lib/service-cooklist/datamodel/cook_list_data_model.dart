import 'package:uuid/uuid.dart';

import '../../features/icons/domain/entities/icon_entity.dart';

const defaultCookIconKey = 'nourriture-repas';

Map<String, dynamic> cookIconToJson(IconEntity icon) => {'key': icon.key};

IconEntity cookIconFromJson(Object? jsonValue) {
  if (jsonValue is! Map) {
    throw const FormatException('An icon reference must be a JSON object.');
  }
  final key = jsonValue['key'];
  if (key is String && key.trim().isNotEmpty) {
    return IconEntity(key: key.trim());
  }
  throw const FormatException('An icon reference must have a non-empty key.');
}

const commonIngredientUnits = ['g', 'kg', 'ml', 'cl', 'l'];

class CookIngredient {
  String name;
  double quantity;
  String unit;

  CookIngredient({this.name = '', this.quantity = 0, this.unit = ''});

  factory CookIngredient.fromJson(Map<String, dynamic> json) {
    return CookIngredient(
      name: json['ingredientName'] as String? ?? '',
      quantity: (json['ingredientQuantity'] as num?)?.toDouble() ?? 0,
      unit: json['ingredientUnit'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'ingredientName': name,
    'ingredientQuantity': quantity,
    'ingredientUnit': unit,
  };

  CookIngredient copy() => CookIngredient.fromJson(toJson());

  String get formattedQuantity {
    if (quantity == quantity.roundToDouble()) {
      return quantity.toInt().toString();
    }
    return double.parse(quantity.toStringAsFixed(3)).toString();
  }

  String get quantityWithUnit {
    final unitText = unit.trim();
    return unitText.isEmpty ? formattedQuantity : '$formattedQuantity $unitText';
  }
}

class CookStep {
  String title;
  IconEntity icon;
  bool state;
  String description;
  String notes;
  String? image;
  List<CookIngredient> ingredients;
  List<String> utensils;

  CookStep({
    this.title = '',
    IconEntity? icon,
    this.state = false,
    this.description = '',
    this.notes = '',
    this.image,
    List<CookIngredient>? ingredients,
    List<String>? utensils,
  }) : icon = IconEntity(key: icon?.key ?? defaultCookIconKey),
       ingredients = ingredients ?? [],
       utensils = utensils ?? [];

  String setImageUuid() {
    final imageUuid = const Uuid().v1().toString().substring(0, 15);
    image = imageUuid;
    return imageUuid;
  }

  void clearImageUuid() {
    image = null;
  }

  factory CookStep.fromJson(Map<String, dynamic> json) {
    final rawIngredients = json['stepIngredients'];
    if (rawIngredients != null && rawIngredients is! List) {
      throw const FormatException('"stepIngredients" must be a list.');
    }
    final rawUtensils = json['stepUtensils'];
    if (rawUtensils != null && rawUtensils is! List) {
      throw const FormatException('"stepUtensils" must be a list.');
    }
    return CookStep(
      utensils: (rawUtensils as List?)
          ?.whereType<String>()
          .map((name) => name.trim())
          .where((name) => name.isNotEmpty)
          .toList(),
      ingredients: (rawIngredients as List?)?.map((item) {
        if (item is! Map) {
          throw const FormatException('Each ingredient must be a JSON object.');
        }
        return CookIngredient.fromJson(Map<String, dynamic>.from(item));
      }).toList(),
      title: json['stepTitle'] as String? ?? '',
      icon: json['stepIcon'] == null
          ? const IconEntity(key: defaultCookIconKey)
          : cookIconFromJson(json['stepIcon']),
      state: json['stepState'] as bool? ?? false,
      description: json['stepDescription'] as String? ?? '',
      notes: json['stepNotes'] as String? ?? '',
      image: json['stepImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'stepTitle': title,
    'stepIcon': cookIconToJson(icon),
    'stepState': state,
    'stepDescription': description,
    'stepNotes': notes,
    'stepImage': image,
    'stepIngredients': ingredients.map((i) => i.toJson()).toList(),
    'stepUtensils': utensils,
  };

  CookStep copyStep() => CookStep.fromJson(toJson());

  void updateWithStep(CookStep source) {
    title = source.title;
    icon = IconEntity(key: source.icon.key);
    description = source.description;
    notes = source.notes;
    image = source.image;
    ingredients = source.ingredients.map((i) => i.copy()).toList();
    utensils = List<String>.of(source.utensils);
  }
}

enum CookType {
  aperitif,
  starter,
  main,
  dessert,
  drink;

  static CookType? fromName(Object? name) {
    for (final type in values) {
      if (type.name == name) return type;
    }
    return null;
  }
}

const defaultCookServings = 4;

/// Reads the labels list; falls back to the former single "genre" field.
List<String> _labelsFromJson(Map<String, dynamic> json) {
  final raw = json['cookListLabels'];
  final values = raw is List
      ? raw.whereType<String>()
      : [json['cookListGenre']].whereType<String>();
  final seen = <String>{};
  return [
    for (final value in values)
      if (value.trim().isNotEmpty && seen.add(value.trim().toLowerCase()))
        value.trim(),
  ];
}

class CookList {
  CookList(
    this.title,
    IconEntity icon,
    this.description,
    this.notes, {
    this.servings = defaultCookServings,
    this.type,
    this.labels = const [],
  }) : icon = IconEntity(key: icon.key),
       uuid = const Uuid().v1(),
       dateTime = DateTime.now().toString();

  String title;
  IconEntity icon;
  String description;
  String notes;
  int servings;
  CookType? type;
  List<String> labels;
  List<CookStep> cookSteps = [];
  String uuid;
  String dateTime;

  factory CookList.fromJson(Map<String, dynamic> json) {
    final cooklist = CookList(
      json['cookListTitle'] as String? ?? '',
      json['cookListIcon'] == null
          ? const IconEntity(key: defaultCookIconKey)
          : cookIconFromJson(json['cookListIcon']),
      json['cookListDescription'] as String? ?? '',
      json['cookListNotes'] as String? ?? '',
      servings: switch ((json['cookListServings'] as num?)?.toInt()) {
        final int value when value >= 1 => value,
        _ => defaultCookServings,
      },
      type: CookType.fromName(json['cookListType']),
      labels: _labelsFromJson(json),
    );

    cooklist.uuid = json['cookListUuid'] as String? ?? cooklist.uuid;
    cooklist.dateTime =
        json['cookListDateTime'] as String? ?? cooklist.dateTime;

    final rawSteps = json['cookListSteps'];
    if (rawSteps != null) {
      if (rawSteps is! List) {
        throw const FormatException('"cookListSteps" must be a list.');
      }
      cooklist.cookSteps = rawSteps.map((item) {
        if (item is! Map) {
          throw const FormatException('Each cook step must be a JSON object.');
        }
        return CookStep.fromJson(Map<String, dynamic>.from(item));
      }).toList();
    }

    return cooklist;
  }

  Map<String, dynamic> toJson() => {
    'cookListTitle': title,
    'cookListIcon': cookIconToJson(icon),
    'cookListDescription': description,
    'cookListNotes': notes,
    'cookListServings': servings,
    'cookListType': type?.name,
    'cookListLabels': labels,
    'cookListSteps': cookSteps.map((step) => step.toJson()).toList(),
    'cookListUuid': uuid,
    'cookListDateTime': dateTime,
  };

  void updateDateTime() {
    dateTime = DateTime.now().toString();
  }

  void addNewStep(int? index) {
    final step = CookStep(
      title: 'New step',
      icon: const IconEntity(key: defaultCookIconKey),
    );
    if (index == null) {
      cookSteps.add(step);
    } else {
      cookSteps.insert(index + 1, step);
    }
  }

  CookList copyCooklist() {
    final copy = CookList.fromJson(toJson());
    copy.uuid = const Uuid().v1();
    copy.updateDateTime();
    return copy;
  }
}

class AppCookLists {
  AppCookLists();

  List<CookList> allCookLists = [];

  factory AppCookLists.fromJson(Map<String, dynamic> json) {
    final rawCooklists = json['allCookLists'];
    if (rawCooklists is! List) {
      throw const FormatException('"allCookLists" must be a list.');
    }

    return AppCookLists()
      ..allCookLists = rawCooklists.map((item) {
        if (item is! Map) {
          throw const FormatException('Each cooklist must be a JSON object.');
        }
        return CookList.fromJson(Map<String, dynamic>.from(item));
      }).toList();
  }

  Map<String, dynamic> toJson() => {
    'allCookLists': allCookLists.map((cooklist) => cooklist.toJson()).toList(),
  };

  void addNewCooklist() {
    final cooklist = CookList(
      'New Cooklist',
      const IconEntity(key: defaultCookIconKey),
      'Describe your recipe here...',
      '',
    )..cookSteps.add(
        CookStep(
          title: 'New step',
          icon: const IconEntity(key: defaultCookIconKey),
        ),
      );
    allCookLists.add(cooklist);
  }

  void addDemoCooklists(List<IconEntity> catalog) {
    final iconKeys = {for (final icon in catalog) icon.key};

    IconEntity icon(String key) {
      if (!iconKeys.contains(key)) {
        throw StateError('Demo icon "$key" is missing from the catalog.');
      }
      return IconEntity(key: key);
    }

    CookStep step(String title, String iconKey, {String description = ''}) =>
        CookStep(title: title, icon: icon(iconKey), description: description);

    final omelette =
        CookList(
            'Cheese omelette',
            icon('nourriture-oeufs'),
            'Quick omelette for two',
            'Serve hot',
            servings: 2,
            type: CookType.main,
            labels: ['omelette'],
          )
          ..cookSteps = [
            step('Beat 4 eggs', 'nourriture-oeufs', description: 'Salt, pepper'),
            step('Grate the cheese', 'nourriture-epicerie'),
            step('Melt butter in a pan', 'nourriture-repas'),
            step('Cook and fold', 'nourriture-dejeuner'),
          ];

    final pancakes =
        CookList(
            'Pancakes',
            icon('nourriture-petit-dejeuner'),
            'Sunday breakfast pancakes',
            '',
            type: CookType.dessert,
            labels: ['pancakes'],
          )
          ..cookSteps = [
            step('Mix flour, eggs and milk', 'nourriture-pain-et-boulangerie'),
            step('Let the batter rest', 'nourriture-boisson'),
            step('Cook in a hot pan', 'nourriture-petit-dejeuner'),
            step('Serve with jam', 'nourriture-gateau'),
          ];

    allCookLists.addAll([omelette, pancakes]);
  }
}
