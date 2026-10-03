import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';

import '../widgets/checklist_icon_picker.dart' show checklistIconOptions;

//import 'package:date_format/date_format.dart';

enum ConnectivityStatus { WiFi, Cellular, Offline }

Map<String, dynamic> iconToJSONString(dynamic icon) {
  final IconData data = icon is FaIconData ? icon.data : icon as IconData;
  Map<String, dynamic> map = <String, dynamic>{};
  map['codePoint'] = data.codePoint;
  map['fontFamily'] = data.fontFamily;
  map['fontPackage'] = data.fontPackage;
  map['matchTextDirection'] = data.matchTextDirection;
  //return jsonEncode(map);
  return map;
}

IconData iconFromJSONString(dynamic jsonString) {
  final Map<String, dynamic> map = Map<String, dynamic>.from(jsonString);
  final codePoint = map['codePoint'] as int;
  final fontFamily = map['fontFamily'] as String?;
  final fontPackage = map['fontPackage'] as String?;

  for (final option in checklistIconOptions) {
    final icon = option.icon;
    if (icon.codePoint == codePoint &&
        icon.fontFamily == fontFamily &&
        icon.fontPackage == fontPackage) {
      return icon;
    }
  }

  return Icons.checklist;
}

class ActionObject {
  String title;
  dynamic icon;
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
    this.image = null;
  }

  factory ActionObject.fromJson(Map<String, dynamic> json) {
    return new ActionObject(
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
    Map<String, dynamic> map = this.toJson();
    return new ActionObject.fromJson(map);
  }

  updateWithActionObject(ActionObject sourceActionObject) {
    this.title = sourceActionObject.title;
    this.icon = sourceActionObject.icon;
    this.description = sourceActionObject.description;
    this.notes = sourceActionObject.notes;
    this.image = sourceActionObject.image;
  }
}

class CheckList {
  static final CheckList _checkListSingleton = new CheckList._internal();

  static CheckList get() {
    return _checkListSingleton;
  }

  CheckList._internal();

  String title = "";
  dynamic icon;
  String description = "";
  String notes = "";
  List<ActionObject> checkListObjects = [];
  late String uuid;
  late String dateTime;

  CheckList(this.title, this.icon, this.description, this.notes) {
    final appUuid = const Uuid();
    this.uuid = appUuid.v1().toString();
    this.dateTime = DateTime.now().toString();
  }

  factory CheckList.fromJson(Map<String, dynamic> json) {
    CheckList _checklist = new CheckList(
      json['checkListTitle'] as String? ?? '',
      json['checkListIcon'] == null
          ? Icons.edit
          : iconFromJSONString(json['checkListIcon']),
      json['checkListDescription'] as String? ?? '',
      json['checkListNotes'] as String? ?? '',
    );

    _checklist.uuid = json['checkListUuid'];
    _checklist.dateTime = json['checkListDateTime'];

    if (json.keys.any((a) => a == 'checkListObjects')) {
      final List<dynamic> dynamicList = json['checkListObjects'] ?? [];
      _checklist.checkListObjects = dynamicList
          .map((item) => ActionObject.fromJson(item))
          .toList();
    }

    return _checklist;
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

  updateDateTime() {
    this.dateTime = DateTime.now().toString();
  }

  updateWithChecklist(CheckList sourceChecklist) {
    this.title = sourceChecklist.title;
    this.icon = sourceChecklist.icon;
    this.description = sourceChecklist.description;
    this.notes = sourceChecklist.notes;
    this.checkListObjects = [];
    this.dateTime = DateTime.now().toString();
    //this.uuid = sourceChecklist.uuid;

    checkListObjects = sourceChecklist.checkListObjects
        .map((action) => action.copyAction())
        .toList();
  }

  void addNewActionObject(int? index) {
    ActionObject _actionObject = new ActionObject();
    _actionObject.title = "New checkpoint";
    _actionObject.description = "Checkpoint description";
    _actionObject.notes = "Checkpoint notes";
    _actionObject.icon = FontAwesomeIcons.edit;
    _actionObject.state = false;

    if (index == null) {
      this.checkListObjects.add(_actionObject);
    } else {
      this.checkListObjects.insert(index + 1, _actionObject);
    }
  }

  CheckList copyChecklist() {
    CheckList varCheckList;
    var appUuid = new Uuid();

    Map<String, dynamic> map = this.toJson();
    varCheckList = new CheckList.fromJson(map);
    varCheckList.uuid = appUuid.v1().toString();
    varCheckList.updateDateTime();
    return varCheckList;
  }

  String generateMd5() {
    Map<String, dynamic> map = this.toJson();
    String encodedMap = jsonEncode(map);
    return md5.convert(utf8.encode(encodedMap)).toString();
  }

  void ivvqFillCheckList(String actionText, int itemNumber, dynamic icon) {
    checkListObjects = new List<ActionObject>.generate(itemNumber, (i) {
      return ActionObject(
        title: actionText + i.toString(),
        icon: icon,
        state: false,
        description: "Description text can be very long for the test and cause issues in the way to display the ------------------------------------------------------------------------------------- text ",
        notes: "Notes can be very long for the test and cause issues in the way to display the --------------------------------------------------------------------------------------------text",
      );
    });
  }
}

class AppCheckLists {
  AppCheckLists();

  List<CheckList> allCheckLists = [];

  factory AppCheckLists.fromJson(Map<String, dynamic> json) {
    AppCheckLists _appCheckLists = new AppCheckLists();

    if (json.keys.any((a) => a == 'allCheckLists')) {
      final List<dynamic> dynamicList = json['allCheckLists'] ?? [];
      _appCheckLists.allCheckLists = dynamicList
          .map((item) => CheckList.fromJson(item))
          .toList();
    } else {
      print(" !!!! beware there is no key found !!!! ");
    }

    return _appCheckLists;
  }

  Map<String, dynamic> toJson() {
    final allCheckListsJson = allCheckLists
        .map((checklist) => checklist.toJson())
        .toList();

    return {'allCheckLists': allCheckListsJson};
  }

  void addNewChecklist() {
    CheckList localChecklist;
    ActionObject localActionObject;

    localChecklist = new CheckList(
      "New Checklist",
      FontAwesomeIcons.edit,
      "Describe your checklist here...",
      "",
    );
    localChecklist.checkListObjects = [];
    localActionObject = new ActionObject(
      title: "New Checkpoint",
      icon: FontAwesomeIcons.edit,
      state: false,
      description: "Describe your checkpoint here...",
      notes: "",
    );
    localChecklist.checkListObjects.add(localActionObject);
    allCheckLists.add(localChecklist);
  }

  void ivvqFillAppCheckList(String checkListText) {
    String ivvqString;
    dynamic ivvqIcon;
    //int ivvqIndex = 0;
    ActionObject localActionObject;
    CheckList localChecklist;

    //int ivvqIndex = 0;
    ivvqString = "Long Travels and Trips and even longer title";
    ivvqIcon = Icons.terrain;
    localChecklist = new CheckList(
      ivvqString,
      ivvqIcon,
      "Travel checklist for long local or abroad trips",
      "No specific notes",
    );
    localChecklist.checkListObjects = [];
    localActionObject = new ActionObject(
      title: "Shoes",
      icon: FontAwesomeIcons.shoePrints,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Socks",
      icon: FontAwesomeIcons.socks,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Pants / shorts / Casual",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Underwear / Swim suit",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Tshirt / Shirt / Tie",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Sweater / Pull Over",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Coat / Jacket",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Belt / Hankerchief / Sun glasses",
      icon: FontAwesomeIcons.glasses,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = new ActionObject(
      title: "Razor / Shaving Cream",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Tooth brush / Paste",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Deodorant / Shower gel",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Medications / Antihistamine / Flower bag",
      icon: FontAwesomeIcons.ambulance,
      state: false,
      description: "Including medications for India",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Toilet Paper / Napkins / Paper Towels / paper tissues",
      icon: FontAwesomeIcons.toiletPaper,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = new ActionObject(
      title: "Phone",
      icon: Icons.phone_android,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Charger / AC adapter",
      icon: Icons.power,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Laptop / Charger",
      icon: Icons.laptop,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "GPS App up to date on phone",
      icon: Icons.location_on,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "TV dongle & cable",
      icon: Icons.location_on,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = new ActionObject(
      title: "Cash / Check Book / Credit Card",
      icon: FontAwesomeIcons.creditCard,
      state: false,
      description: "Local currency (US, India)",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "ID / Passport (including kids)",
      icon: FontAwesomeIcons.idCard,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Contacts phone / Travel insurrance",
      icon: FontAwesomeIcons.userFriends,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Phone list / Reservations ",
      icon: FontAwesomeIcons.addressBook,
      state: false,
      description: "(flight, car rental, hotel...)",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Taxi reservation departure flight",
      icon: FontAwesomeIcons.taxi,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Books / Paper for notes / Pen",
      icon: Icons.import_contacts,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = new ActionObject(
      title: "Movies for the car / TV screens",
      icon: Icons.movie,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Books & Activities for kids",
      icon: Icons.toys,
      state: false,
      description: "Take bag for middel seat",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Water / Snacks / Food",
      icon: Icons.fastfood,
      state: false,
      description: "Paper towels for cleaning",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Lamps for emergency or night",
      icon: Icons.lightbulb_outline,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Salt / Pepper / oil / Vinegar",
      icon: FontAwesomeIcons.oilCan,
      state: false,
      description: "Including Al foil",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Sponge / detergent / Dishwasher tablet / Towel",
      icon: FontAwesomeIcons.medkit,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Bed Sheets / Bathroom or beach towels",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Hiking or small bags",
      icon: FontAwesomeIcons.shoppingBag,
      state: false,
      description: " ",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Head lamp / Swiss knife / ",
      icon: Icons.lightbulb_outline,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = new ActionObject(
      title: "Empty the dryer water tank",
      icon: FontAwesomeIcons.water,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Water the plants",
      icon: FontAwesomeIcons.leaf,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Empty fridge",
      icon: Icons.fastfood,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);

    localActionObject = new ActionObject(
      title: "Turn water heater off (summer)",
      icon: FontAwesomeIcons.water,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Turn PC & Wifi power off",
      icon: FontAwesomeIcons.powerOff,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Put trash & recycling out",
      icon: FontAwesomeIcons.trash,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Susan car in garage",
      icon: Icons.directions_car,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "check lights are off",
      icon: Icons.lightbulb_outline,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "All doors closed",
      icon: FontAwesomeIcons.doorClosed,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    allCheckLists.add(localChecklist);

    //ivvqIndex = 1;
    ivvqString = "Paris Trip";
    ivvqIcon = Icons.airplanemode_active;
    localChecklist = new CheckList(
      ivvqString,
      ivvqIcon,
      "Travel checklist for Paris trips",
      "No specific notes",
    );

    localChecklist.checkListObjects = [];
    localActionObject = new ActionObject(
      title: "Socks",
      icon: FontAwesomeIcons.socks,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Underwear",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Tshirt",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Shirt",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Spare pants",
      icon: FontAwesomeIcons.tshirt,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Razor / Toothbrush / cream...",
      icon: FontAwesomeIcons.shower,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Phone Cable",
      icon: Icons.power,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Thales Badge",
      icon: Icons.badge,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Drivers licence",
      icon: Icons.credit_card,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "ID",
      icon: Icons.credit_card,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    allCheckLists.add(localChecklist);

    //ivvqIndex = 2;
    ivvqString = "René school";
    ivvqIcon = Icons.school;

    localChecklist = new CheckList(
      ivvqString,
      ivvqIcon,
      "Check before school",
      "No specific notes",
    );
    //allCheckLists[IVVQIndex] = new CheckList(ivvqString, ivvqIcon, "Check before school", "No specific notes");
    localChecklist.checkListObjects = [];
    localActionObject = new ActionObject(
      title: "Phone",
      icon: Icons.phone,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Carnet correspondance",
      icon: Icons.import_contacts,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Carte cantine",
      icon: Icons.credit_card,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
      title: "Keys",
      icon: Icons.vpn_key,
      state: false,
      description: "Description",
      notes: "Notes",
    );
    localChecklist.checkListObjects.add(localActionObject);
    localActionObject = new ActionObject(
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
