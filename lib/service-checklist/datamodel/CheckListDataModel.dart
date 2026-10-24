import 'package:uuid/uuid.dart';

import '../../features/icons/domain/entities/icon_entity.dart';

const defaultChecklistIconKey = 'essentiel-checklist';

Map<String, dynamic> iconToJSONString(IconEntity icon) => {'key': icon.key};

IconEntity iconFromJSONString(
  Object? jsonValue, {
  Map<String, String> legacyIconKeys = const {},
}) {
  if (jsonValue is! Map) {
    throw const FormatException('An icon reference must be a JSON object.');
  }
  final map = Map<String, dynamic>.from(jsonValue);
  final key = map['key'];
  if (key is String && key.trim().isNotEmpty) {
    return IconEntity(key: key.trim());
  }
  if (key is String) {
    throw const FormatException('An icon reference must have a non-empty key.');
  }

  final codePoint = map['codePoint'];
  final fontFamily = map['fontFamily'];
  if (codePoint is int && fontFamily is String) {
    final fontPackage = map['fontPackage'] as String? ?? 'material';
    final legacyKey =
        legacyIconKeys['$fontPackage|$fontFamily|${codePoint.toRadixString(16)}'];
    if (legacyKey != null) return IconEntity(key: legacyKey);
  }

  throw const FormatException(
    'The saved icon has no key and cannot be matched to the current catalog.',
  );
}

class ActionObject {
  String title;
  IconEntity icon;
  bool state;
  String description;
  String notes;
  String? image;

  ActionObject({
    this.title = '',
    IconEntity? icon,
    this.state = false,
    this.description = '',
    this.notes = '',
    this.image,
  }) : icon = IconEntity(key: icon?.key ?? defaultChecklistIconKey);

  String setImageUuid() {
    final appUuid = const Uuid().v1().toString().substring(0, 15);
    image = appUuid;
    return appUuid;
  }

  void clearImageUuid() {
    image = null;
  }

  factory ActionObject.fromJson(
    Map<String, dynamic> json, {
    Map<String, String> legacyIconKeys = const {},
  }) {
    return ActionObject(
      title: json['actionTitle'] as String? ?? '',
      icon: json['actionIcon'] == null
          ? const IconEntity(key: defaultChecklistIconKey)
          : iconFromJSONString(
              json['actionIcon'],
              legacyIconKeys: legacyIconKeys,
            ),
      state: json['actionState'] as bool? ?? false,
      description: json['actionDescription'] as String? ?? '',
      notes: json['actionNotes'] as String? ?? '',
      image: json['actionImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'actionTitle': title,
    'actionIcon': iconToJSONString(icon),
    'actionState': state,
    'actionDescription': description,
    'actionNotes': notes,
    'actionImage': image,
  };

  ActionObject copyAction() {
    return ActionObject.fromJson(toJson());
  }

  void updateWithActionObject(ActionObject sourceActionObject) {
    title = sourceActionObject.title;
    icon = IconEntity(key: sourceActionObject.icon.key);
    description = sourceActionObject.description;
    notes = sourceActionObject.notes;
    image = sourceActionObject.image;
  }
}

class CheckList {
  CheckList(this.title, IconEntity icon, this.description, this.notes)
    : icon = IconEntity(key: icon.key),
      uuid = const Uuid().v1(),
      dateTime = DateTime.now().toString();

  String title;
  IconEntity icon;
  String description;
  String notes;
  List<ActionObject> checkListObjects = [];
  String uuid;
  String dateTime;

  factory CheckList.fromJson(
    Map<String, dynamic> json, {
    Map<String, String> legacyIconKeys = const {},
  }) {
    final checklist = CheckList(
      json['checkListTitle'] as String? ?? '',
      json['checkListIcon'] == null
          ? const IconEntity(key: defaultChecklistIconKey)
          : iconFromJSONString(
              json['checkListIcon'],
              legacyIconKeys: legacyIconKeys,
            ),
      json['checkListDescription'] as String? ?? '',
      json['checkListNotes'] as String? ?? '',
    );

    checklist.uuid = json['checkListUuid'] as String? ?? checklist.uuid;
    checklist.dateTime =
        json['checkListDateTime'] as String? ?? checklist.dateTime;

    final rawActions = json['checkListObjects'];
    if (rawActions != null) {
      if (rawActions is! List) {
        throw const FormatException('"checkListObjects" must be a list.');
      }
      checklist.checkListObjects = rawActions.map((item) {
        if (item is! Map) {
          throw const FormatException(
            'Each checklist action must be a JSON object.',
          );
        }
        return ActionObject.fromJson(
          Map<String, dynamic>.from(item),
          legacyIconKeys: legacyIconKeys,
        );
      }).toList();
    }

    return checklist;
  }

  Map<String, dynamic> toJson() {
    final actionItems = checkListObjects.map((item) => item.toJson()).toList();

    return {
      'checkListTitle': title,
      'checkListIcon': iconToJSONString(icon),
      'checkListDescription': description,
      'checkListNotes': notes,
      'checkListObjects': actionItems,
      'checkListUuid': uuid,
      'checkListDateTime': dateTime,
    };
  }

  void updateDateTime() {
    dateTime = DateTime.now().toString();
  }

  void addNewActionObject(int? index) {
    final actionObject = ActionObject(
      title: 'New checkpoint',
      icon: const IconEntity(key: defaultChecklistIconKey),
    );
    if (index == null) {
      checkListObjects.add(actionObject);
    } else {
      checkListObjects.insert(index + 1, actionObject);
    }
  }

  CheckList copyChecklist() {
    final copy = CheckList.fromJson(toJson());
    copy.uuid = const Uuid().v1();
    copy.updateDateTime();
    return copy;
  }
}

class AppCheckLists {
  AppCheckLists();

  List<CheckList> allCheckLists = [];

  factory AppCheckLists.fromJson(
    Map<String, dynamic> json, {
    Map<String, String> legacyIconKeys = const {},
  }) {
    final rawChecklists = json['allCheckLists'];
    if (rawChecklists is! List) {
      throw const FormatException('"allCheckLists" must be a list.');
    }

    return AppCheckLists()
      ..allCheckLists = rawChecklists.map((item) {
        if (item is! Map) {
          throw const FormatException('Each checklist must be a JSON object.');
        }
        return CheckList.fromJson(
          Map<String, dynamic>.from(item),
          legacyIconKeys: legacyIconKeys,
        );
      }).toList();
  }

  Map<String, dynamic> toJson() {
    final allCheckListsJson = allCheckLists
        .map((checklist) => checklist.toJson())
        .toList();

    return {'allCheckLists': allCheckListsJson};
  }

  void addNewChecklist() {
    final checklist =
        CheckList(
            'New Checklist',
            const IconEntity(key: defaultChecklistIconKey),
            'Describe your checklist here...',
            '',
          )
          ..checkListObjects.add(
            ActionObject(
              title: 'New Checkpoint',
              icon: const IconEntity(key: defaultChecklistIconKey),
            ),
          );
    allCheckLists.add(checklist);
  }

  void addDemoChecklists(List<IconEntity> catalog) {
    final iconsByKey = {
      for (final icon in catalog) icon.key: IconEntity(key: icon.key),
    };

    IconEntity icon(String key) {
      return iconsByKey[key] ??
          (throw StateError('Demo icon "$key" is missing from the catalog.'));
    }

    ActionObject action(
      String title,
      String iconKey, {
      String description = 'Description',
      String notes = 'Notes',
    }) => ActionObject(
      title: title,
      icon: icon(iconKey),
      description: description,
      notes: notes,
    );

    final longTrip =
        CheckList(
            'Long Travels and Trips and even longer title',
            icon('voyage-randonnee'),
            'Travel checklist for long local or abroad trips',
            'No specific notes',
          )
          ..checkListObjects = [
            action('Shoes', 'vetements-shoes'),
            action('Socks', 'vetements-chaussettes'),
            action('Pants / shorts / Casual', 'vetements-pantalon'),
            action('Underwear / Swim suit', 'vetements-pantalon-court'),
            action('Tshirt / Shirt / Tie', 'vetements-chemise'),
            action('Sweater / Pull Over', 'vetements-sweatshirt'),
            action('Coat / Jacket', 'vetements-veste'),
            action(
              'Belt / Hankerchief / Sun glasses',
              'vetements-lunettes-de-soleil',
            ),
            action(
              'Razor / Shaving Cream',
              'objets-de-voyage-trousse-de-toilette',
            ),
            action(
              'Tooth brush / Paste',
              'objets-de-voyage-trousse-de-toilette',
            ),
            action(
              'Deodorant / Shower gel',
              'objets-de-voyage-trousse-de-toilette',
            ),
            action(
              'Medications / Antihistamine / Flower bag',
              'objets-de-voyage-medicaments',
              description: 'Including medications for India',
            ),
            action(
              'Toilet Paper / Napkins / Paper Towels / paper tissues',
              'objets-de-voyage-mouchoirs',
              description: ' ',
            ),
            action('Phone', 'technologie-telephone'),
            action('Charger / AC adapter', 'objets-de-voyage-chargeur'),
            action('Laptop / Charger', 'technologie-ordinateur'),
            action('GPS App up to date on phone', 'voyage-carte'),
            action('TV dongle & cable', 'technologie-ecran'),
            action(
              'Cash / Check Book / Credit Card',
              'objets-de-voyage-carte-bancaire',
              description: 'Local currency (US, India)',
            ),
            action(
              'ID / Passport (including kids)',
              'objets-de-voyage-passeport',
              description: ' ',
            ),
            action(
              'Contacts phone / Travel insurrance',
              'famille-contacts',
              description: ' ',
            ),
            action(
              'Phone list / Reservations ',
              'objets-de-voyage-billet-et-reservation',
              description: '(flight, car rental, hotel...)',
            ),
            action(
              'Taxi reservation departure flight',
              'voyage-taxi',
              description: ' ',
            ),
            action(
              'Books / Paper for notes / Pen',
              'loisirs-lecture',
              description: ' ',
            ),
            action(
              'Movies for the car / TV screens',
              'loisirs-film',
              description: ' ',
            ),
            action(
              'Books & Activities for kids',
              'famille-enfant',
              description: 'Take bag for middel seat',
            ),
            action(
              'Water / Snacks / Food',
              'nourriture-repas',
              description: 'Paper towels for cleaning',
            ),
            action(
              'Lamps for emergency or night',
              'maison-eclairage',
              description: ' ',
            ),
            action(
              'Salt / Pepper / oil / Vinegar',
              'nourriture-courses-alimentaires',
              description: 'Including Al foil',
            ),
            action(
              'Sponge / detergent / Dishwasher tablet / Towel',
              'maison-nettoyage',
              description: ' ',
            ),
            action(
              'Bed Sheets / Bathroom or beach towels',
              'maison-literie',
              description: ' ',
            ),
            action(
              'Hiking or small bags',
              'objets-de-voyage-sac-a-dos',
              description: ' ',
            ),
            action('Head lamp / Swiss knife / ', 'maison-ampoule-contour'),
            action('Empty the dryer water tank', 'maison-eau'),
            action('Water the plants', 'maison-plante'),
            action('Empty fridge', 'nourriture-fruits-et-legumes'),
            action('Turn water heater off (summer)', 'maison-eau'),
            action('Turn PC & Wifi power off', 'technologie-wi-fi'),
            action('Put trash & recycling out', 'maison-recyclage'),
            action('Susan car in garage', 'voyage-voiture'),
            action('check lights are off', 'maison-eclairage'),
            action('All doors closed', 'maison-porte'),
          ];

    final parisTrip =
        CheckList(
            'Paris Trip',
            icon('voyage-avion'),
            'Travel checklist for Paris trips',
            'No specific notes',
          )
          ..checkListObjects = [
            action('Socks', 'vetements-chaussettes'),
            action('Underwear', 'vetements-pantalon-court'),
            action('Tshirt', 'vetements-t-shirt'),
            action('Shirt', 'vetements-chemise'),
            action('Spare pants', 'vetements-bermuda'),
            action(
              'Razor / Toothbrush / cream...',
              'objets-de-voyage-trousse-de-toilette',
            ),
            action('Phone Cable', 'objets-de-voyage-chargeur'),
            action('Thales Badge', 'famille-badge'),
            action('Drivers licence', 'objets-de-voyage-documents'),
            action('ID', 'objets-de-voyage-passeport'),
          ];

    final school =
        CheckList(
            'René school',
            icon('famille-ecole'),
            'Check before school',
            'No specific notes',
          )
          ..checkListObjects = [
            action('Phone', 'technologie-telephone'),
            action('Carnet correspondance', 'objets-de-voyage-documents'),
            action('Carte cantine', 'objets-de-voyage-carte-bancaire'),
            action('Keys', 'maison-cles'),
            action('Sport bag', 'famille-sac-a-dos'),
          ];

    allCheckLists.addAll([longTrip, parisTrip, school]);
  }
}
