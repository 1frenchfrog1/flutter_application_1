import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../features/icons/data/models/icon_model.dart';
import '../../features/icons/domain/entities/icon_entity.dart';

Map<String, dynamic> iconToJSONString(Object icon) {
  if (icon is IconEntity) {
    return IconModel.fromEntity(icon).toJson();
  }

  final IconData data;
  if (icon is FaIconData) {
    data = icon.data;
  } else if (icon is IconData) {
    data = icon;
  } else {
    throw ArgumentError.value(icon, 'icon', 'Unsupported checklist icon.');
  }

  return {
    'codePoint': data.codePoint,
    'fontFamily': data.fontFamily,
    'fontPackage': data.fontPackage,
    'matchTextDirection': data.matchTextDirection,
  };
}

Object iconFromJSONString(Object? jsonValue) {
  if (jsonValue is! Map) return Icons.checklist;

  final map = Map<String, dynamic>.from(jsonValue);
  if (map['key'] is! String) {
    return Icons.checklist;
  }

  return IconModel.fromJson(map).toEntity();
}

class ActionObject {
  String title;
  Object icon;
  bool state;
  String description;
  String notes;
  String? image;

  ActionObject({
    this.title = '',
    this.icon = Icons.edit,
    this.state = false,
    this.description = '',
    this.notes = '',
    this.image,
  });

  String setImageUuid() {
    final appUuid = const Uuid().v1().toString().substring(0, 15);
    image = appUuid;
    return appUuid;
  }

  void clearImageUuid() {
    image = null;
  }

  factory ActionObject.fromJson(Map<String, dynamic> json) {
    return ActionObject(
      title: json['actionTitle'] as String? ?? '',
      icon: json['actionIcon'] == null
          ? Icons.edit
          : iconFromJSONString(json['actionIcon']),
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
    icon = sourceActionObject.icon;
    description = sourceActionObject.description;
    notes = sourceActionObject.notes;
    image = sourceActionObject.image;
  }
}

class CheckList {
  CheckList(this.title, this.icon, this.description, this.notes)
    : uuid = const Uuid().v1(),
      dateTime = DateTime.now().toString();

  String title;
  Object icon;
  String description;
  String notes;
  List<ActionObject> checkListObjects = [];
  String uuid;
  String dateTime;

  factory CheckList.fromJson(Map<String, dynamic> json) {
    final checklist = CheckList(
      json['checkListTitle'] as String? ?? '',
      json['checkListIcon'] == null
          ? Icons.edit
          : iconFromJSONString(json['checkListIcon']),
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
        return ActionObject.fromJson(Map<String, dynamic>.from(item));
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
      icon: FontAwesomeIcons.penToSquare,
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

  factory AppCheckLists.fromJson(Map<String, dynamic> json) {
    final rawChecklists = json['allCheckLists'];
    if (rawChecklists is! List) {
      throw const FormatException('"allCheckLists" must be a list.');
    }

    return AppCheckLists()
      ..allCheckLists = rawChecklists.map((item) {
        if (item is! Map) {
          throw const FormatException('Each checklist must be a JSON object.');
        }
        return CheckList.fromJson(Map<String, dynamic>.from(item));
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
            FontAwesomeIcons.penToSquare,
            'Describe your checklist here...',
            '',
          )
          ..checkListObjects.add(
            ActionObject(
              title: 'New Checkpoint',
              icon: FontAwesomeIcons.penToSquare,
            ),
          );
    allCheckLists.add(checklist);
  }

  void addDemoChecklists() {
    String ivvqString;
    IconData ivvqIcon;
    ActionObject localActionObject;
    CheckList localChecklist;

    ivvqString = 'Long Travels and Trips and even longer title';
    ivvqIcon = Icons.terrain;
    localChecklist = CheckList(
      ivvqString,
      ivvqIcon,
      "Travel checklist for long local or abroad trips",
      "No specific notes",
    );
    localChecklist.checkListObjects = [];
    localActionObject = ActionObject(
      title: "Shoes",
      icon: FontAwesomeIcons.shoePrints,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Socks",
      icon: FontAwesomeIcons.socks,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Pants / shorts / Casual",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Underwear / Swim suit",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Tshirt / Shirt / Tie",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Sweater / Pull Over",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Coat / Jacket",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Belt / Hankerchief / Sun glasses",
      icon: FontAwesomeIcons.glasses,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = ActionObject(
      title: "Razor / Shaving Cream",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Tooth brush / Paste",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Deodorant / Shower gel",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Medications / Antihistamine / Flower bag",
      icon: FontAwesomeIcons.truckMedical,
      state: false,
      description: "Including medications for India",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Toilet Paper / Napkins / Paper Towels / paper tissues",
      icon: FontAwesomeIcons.toiletPaper,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = ActionObject(
      title: "Phone",
      icon: Icons.phone_android,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Charger / AC adapter",
      icon: Icons.power,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Laptop / Charger",
      icon: Icons.laptop,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "GPS App up to date on phone",
      icon: Icons.location_on,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "TV dongle & cable",
      icon: Icons.location_on,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = ActionObject(
      title: "Cash / Check Book / Credit Card",
      icon: FontAwesomeIcons.creditCard,
      state: false,
      description: "Local currency (US, India)",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "ID / Passport (including kids)",
      icon: FontAwesomeIcons.idCard,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Contacts phone / Travel insurrance",
      icon: FontAwesomeIcons.userGroup,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Phone list / Reservations ",
      icon: FontAwesomeIcons.addressBook,
      state: false,
      description: "(flight, car rental, hotel...)",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Taxi reservation departure flight",
      icon: FontAwesomeIcons.taxi,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Books / Paper for notes / Pen",
      icon: Icons.import_contacts,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = ActionObject(
      title: "Movies for the car / TV screens",
      icon: Icons.movie,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Books & Activities for kids",
      icon: Icons.toys,
      state: false,
      description: "Take bag for middel seat",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Water / Snacks / Food",
      icon: Icons.fastfood,
      state: false,
      description: "Paper towels for cleaning",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Lamps for emergency or night",
      icon: Icons.lightbulb_outline,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Salt / Pepper / oil / Vinegar",
      icon: FontAwesomeIcons.oilCan,
      state: false,
      description: "Including Al foil",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Sponge / detergent / Dishwasher tablet / Towel",
      icon: FontAwesomeIcons.suitcaseMedical,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Bed Sheets / Bathroom or beach towels",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Hiking or small bags",
      icon: FontAwesomeIcons.bagShopping,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Head lamp / Swiss knife / ",
      icon: Icons.lightbulb_outline,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = ActionObject(
      title: "Empty the dryer water tank",
      icon: FontAwesomeIcons.water,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Water the plants",
      icon: FontAwesomeIcons.leaf,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Empty fridge",
      icon: Icons.fastfood,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = ActionObject(
      title: "Turn water heater off (summer)",
      icon: FontAwesomeIcons.water,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Turn PC & Wifi power off",
      icon: FontAwesomeIcons.powerOff,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Put trash & recycling out",
      icon: FontAwesomeIcons.trash,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Susan car in garage",
      icon: Icons.directions_car,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "check lights are off",
      icon: Icons.lightbulb_outline,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "All doors closed",
      icon: FontAwesomeIcons.doorClosed,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    allCheckLists.add(localChecklist);

    ivvqString = 'Paris Trip';
    ivvqIcon = Icons.airplanemode_active;
    localChecklist = CheckList(
      ivvqString,
      ivvqIcon,
      "Travel checklist for Paris trips",
      "No specific notes",
    );

    localChecklist.checkListObjects = [];
    localActionObject = ActionObject(
      title: "Socks",
      icon: FontAwesomeIcons.socks,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Underwear",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Tshirt",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Shirt",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Spare pants",
      icon: FontAwesomeIcons.shirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Razor / Toothbrush / cream...",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Phone Cable",
      icon: Icons.power,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Thales Badge",
      icon: Icons.badge,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Drivers licence",
      icon: Icons.credit_card,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "ID",
      icon: Icons.credit_card,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    allCheckLists.add(localChecklist);

    ivvqString = 'René school';
    ivvqIcon = Icons.school;

    localChecklist = CheckList(
      ivvqString,
      ivvqIcon,
      "Check before school",
      "No specific notes",
    );
    localChecklist.checkListObjects = [];
    localActionObject = ActionObject(
      title: "Phone",
      icon: Icons.phone,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Carnet correspondance",
      icon: Icons.import_contacts,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Carte cantine",
      icon: Icons.credit_card,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Keys",
      icon: Icons.vpn_key,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = ActionObject(
      title: "Sport bag",
      icon: Icons.work,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    allCheckLists.add(localChecklist);
  }
}
