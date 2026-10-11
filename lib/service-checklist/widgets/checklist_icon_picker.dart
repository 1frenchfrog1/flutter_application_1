import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';

class ChecklistIconOption {
  final String label;
  final String category;
  final dynamic icon;
  final String? hugeIconName;

  const ChecklistIconOption(this.label, this.category, this.icon)
    : hugeIconName = null;

  const ChecklistIconOption.huge(
    this.label,
    this.category,
    this.hugeIconName,
    this.icon,
  );
}

const checklistTrousersIcon = IconData(0xe000, fontFamily: 'ChecklistCustom');

class ChecklistIconView extends StatelessWidget {
  final dynamic icon;
  final double? size;

  const ChecklistIconView({super.key, required this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    if (icon is List<List<dynamic>>) {
      return HugeIcon(
        icon: icon,
        size: size ?? IconTheme.of(context).size ?? 24,
        color: IconTheme.of(context).color,
      );
    }

    if (icon is FaIconData) {
      return FaIcon(icon, size: size);
    }

    if (icon is! IconData) return const Icon(Icons.checklist);
    if (icon.codePoint != checklistTrousersIcon.codePoint ||
        icon.fontFamily != checklistTrousersIcon.fontFamily) {
      return Icon(icon, size: size);
    }

    final iconSize = size ?? IconTheme.of(context).size ?? 24;
    return CustomPaint(
      size: Size.square(iconSize),
      painter: _TrousersIconPainter(
        color:
            IconTheme.of(context).color ??
            Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _TrousersIconPainter extends CustomPainter {
  final Color color;

  const _TrousersIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 100, size.height / 100);

    final trousers = Path()
      ..moveTo(25, 12)
      ..lineTo(75, 12)
      ..lineTo(72, 50)
      ..lineTo(62, 91)
      ..lineTo(47, 91)
      ..lineTo(49, 53)
      ..lineTo(42, 53)
      ..lineTo(37, 91)
      ..lineTo(22, 91)
      ..lineTo(28, 50)
      ..close();
    canvas.drawPath(trousers, Paint()..color = color);

    final seam = Paint()
      ..color = color.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(const Offset(28, 20), const Offset(72, 20), seam);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_TrousersIconPainter oldDelegate) =>
      color != oldDelegate.color;
}

final List<ChecklistIconOption> checklistIconOptions = [
  // Use the package's font metadata directly because its IconData subclasses
  // are incompatible with current Flutter SDKs.
  ChecklistIconOption('Checklist', 'Essentiel', Icons.checklist),
  ChecklistIconOption('Tâche validée', 'Essentiel', Icons.task_alt),
  ChecklistIconOption('Objectif', 'Essentiel', Icons.flag_outlined),
  ChecklistIconOption('Favori', 'Essentiel', Icons.star_outline),
  ChecklistIconOption('Rappel', 'Essentiel', Icons.alarm_outlined),
  ChecklistIconOption(
    'Presse-papiers',
    'Essentiel',
    const IconData(0xe939, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption(
    'Tâche terminée',
    'Essentiel',
    const IconData(0xe930, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption(
    'Calendrier',
    'Essentiel',
    const IconData(0xec32, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Ancienne icône édition', 'Essentiel', Icons.edit),
  ChecklistIconOption(
    'Ancienne édition Font Awesome',
    'Essentiel',
    FontAwesomeIcons.penToSquare.data,
  ),
  ChecklistIconOption('Ancienne icône suppression', 'Essentiel', Icons.delete),
  ChecklistIconOption('Ancienne icône terminé', 'Essentiel', Icons.done_all),
  ChecklistIconOption('Ancienne icône objectif', 'Essentiel', Icons.flag),
  ChecklistIconOption('Ancienne icône alarme', 'Essentiel', Icons.access_alarm),
  ChecklistIconOption('Ancienne icône compte', 'Famille', Icons.account_circle),
  ChecklistIconOption('Ancienne icône photo', 'Technologie', Icons.add_a_photo),
  ChecklistIconOption(
    'Ancienne icône siège',
    'Objets de voyage',
    Icons.airline_seat_individual_suite,
  ),
  ChecklistIconOption(
    'Ancienne icône siège inclinable',
    'Objets de voyage',
    Icons.airline_seat_recline_normal,
  ),
  ChecklistIconOption(
    'Ancienne icône avion',
    'Voyage',
    Icons.airplanemode_active,
  ),
  ChecklistIconOption(
    'Ancienne icône identité',
    'Famille',
    Icons.assignment_ind,
  ),
  ChecklistIconOption('Ancienne icône musique', 'Loisirs', Icons.audiotrack),
  ChecklistIconOption(
    'Ancienne icône luminosité',
    'Technologie',
    Icons.brightness_low,
  ),
  ChecklistIconOption(
    'Ancienne icône affaires',
    'Essentiel',
    Icons.business_center,
  ),
  ChecklistIconOption('Ancienne icône outils', 'Essentiel', Icons.build),
  ChecklistIconOption('Ancienne icône soleil', 'Maison', Icons.wb_sunny),
  ChecklistIconOption(
    'Ancienne icône départ',
    'Objets de voyage',
    Icons.time_to_leave,
  ),
  ChecklistIconOption(
    'Ancienne icône téléphone',
    'Technologie',
    Icons.phone_android,
  ),
  ChecklistIconOption(
    'Ancienne icône alimentation',
    'Technologie',
    Icons.power,
  ),
  ChecklistIconOption('Ancienne icône ordinateur', 'Technologie', Icons.laptop),
  ChecklistIconOption('Ancienne icône position', 'Voyage', Icons.location_on),
  ChecklistIconOption(
    'Ancienne icône contacts',
    'Famille',
    Icons.import_contacts,
  ),
  ChecklistIconOption('Ancienne icône film', 'Loisirs', Icons.movie),
  ChecklistIconOption('Ancienne icône jouet', 'Loisirs', Icons.toys),
  ChecklistIconOption(
    'Ancienne icône repas rapide',
    'Nourriture',
    Icons.fastfood,
  ),
  ChecklistIconOption(
    'Ancienne icône ampoule',
    'Maison',
    Icons.lightbulb_outline,
  ),
  ChecklistIconOption('Ancienne icône voiture', 'Voyage', Icons.directions_car),
  ChecklistIconOption(
    'Ancienne icône téléphone fixe',
    'Technologie',
    Icons.phone,
  ),
  ChecklistIconOption('Ancienne icône clé', 'Maison', Icons.vpn_key),
  ChecklistIconOption('Ancienne icône travail', 'Essentiel', Icons.work),
  ChecklistIconOption('Ancienne icône terrain', 'Voyage', Icons.terrain),
  ChecklistIconOption('Ancienne icône école', 'Famille', Icons.school),
  ChecklistIconOption(
    'Ancienne icône restaurant',
    'Nourriture',
    Icons.restaurant,
  ),
  ChecklistIconOption(
    'Ancienne icône badge',
    'Voyage',
    FontAwesomeIcons.idCard.data,
  ),
  ChecklistIconOption(
    'Ancienne icône taxi',
    'Voyage',
    FontAwesomeIcons.taxi.data,
  ),
  ChecklistIconOption(
    'Ancienne icône chaussures',
    'Vêtements',
    FontAwesomeIcons.shoePrints.data,
  ),
  ChecklistIconOption(
    'Ancienne icône chaussettes',
    'Vêtements',
    FontAwesomeIcons.socks.data,
  ),
  ChecklistIconOption(
    'Ancienne icône t-shirt',
    'Vêtements',
    FontAwesomeIcons.shirt.data,
  ),
  ChecklistIconOption(
    'Ancienne icône lunettes',
    'Vêtements',
    FontAwesomeIcons.glasses.data,
  ),
  ChecklistIconOption(
    'Ancienne icône douche',
    'Maison',
    FontAwesomeIcons.shower.data,
  ),
  ChecklistIconOption(
    'Ancienne icône ambulance',
    'Santé',
    FontAwesomeIcons.truckMedical.data,
  ),
  ChecklistIconOption(
    'Ancienne icône papier toilette',
    'Objets de voyage',
    FontAwesomeIcons.toiletPaper.data,
  ),
  ChecklistIconOption(
    'Ancienne icône carte bancaire',
    'Objets de voyage',
    FontAwesomeIcons.creditCard.data,
  ),
  ChecklistIconOption(
    'Ancienne icône contacts groupe',
    'Famille',
    FontAwesomeIcons.userGroup.data,
  ),
  ChecklistIconOption(
    'Ancienne icône carnet',
    'Famille',
    FontAwesomeIcons.addressBook.data,
  ),
  ChecklistIconOption(
    'Ancienne icône huile',
    'Nourriture',
    FontAwesomeIcons.oilCan.data,
  ),
  ChecklistIconOption(
    'Ancienne icône trousse médicale',
    'Santé',
    FontAwesomeIcons.suitcaseMedical.data,
  ),
  ChecklistIconOption(
    'Ancienne icône sac',
    'Objets de voyage',
    FontAwesomeIcons.bagShopping.data,
  ),
  ChecklistIconOption(
    'Ancienne icône eau',
    'Maison',
    FontAwesomeIcons.water.data,
  ),
  ChecklistIconOption(
    'Ancienne icône plante',
    'Maison',
    FontAwesomeIcons.leaf.data,
  ),
  ChecklistIconOption(
    'Ancienne icône poubelle',
    'Maison',
    FontAwesomeIcons.trash.data,
  ),
  ChecklistIconOption(
    'Ancienne icône porte',
    'Maison',
    FontAwesomeIcons.doorClosed.data,
  ),
  ChecklistIconOption(
    'Ancienne icône arrêt',
    'Technologie',
    FontAwesomeIcons.powerOff.data,
  ),

  ChecklistIconOption('T-shirt', 'Vêtements', FontAwesomeIcons.shirt.data),
  ChecklistIconOption.huge(
    'Pantalon',
    'Vêtements',
    'strokeRoundedJoggerPants',
    HugeIcons.strokeRoundedJoggerPants,
  ),
  ChecklistIconOption.huge(
    'Pantalon court',
    'Vêtements',
    'strokeRoundedShortsPants',
    HugeIcons.strokeRoundedShortsPants,
  ),
  ChecklistIconOption.huge(
    'Robe',
    'Vêtements',
    'Robe',
    HugeIcons.strokeRoundedDress05,
  ),
  ChecklistIconOption.huge(
    'Shoes',
    'Vêtements',
    'Shoes',
    HugeIcons.strokeRoundedShoes,
  ),
  ChecklistIconOption(
    'Short',
    'Vêtements',
    const IconData(0xf145, fontFamily: 'MingCute', fontPackage: 'icons_plus'),
  ),

  ChecklistIconOption(
    'Chemise',
    'Vêtements',
    const IconData(0xf135, fontFamily: 'MingCute', fontPackage: 'icons_plus'),
  ),

  ChecklistIconOption.huge(
    'Chemise',
    'Vêtements',
    'strokeRoundedShirt01',
    HugeIcons.strokeRoundedShirt01,
  ),
  ChecklistIconOption('Veste et manteau', 'Vêtements', Icons.checkroom),
  ChecklistIconOption('Pull', 'Vêtements', Icons.checkroom),
  ChecklistIconOption('Robe', 'Vêtements', Icons.checkroom),
  ChecklistIconOption(
    'Chaussures',
    'Vêtements',
    FontAwesomeIcons.shoePrints.data,
  ),
  ChecklistIconOption('Chaussettes', 'Vêtements', FontAwesomeIcons.socks.data),
  ChecklistIconOption(
    'Lunettes de soleil',
    'Vêtements',
    FontAwesomeIcons.glasses.data,
  ),
  ChecklistIconOption(
    'Tenue à laver',
    'Vêtements',
    Icons.local_laundry_service_outlined,
  ),
  ChecklistIconOption(
    'Nettoyage à sec',
    'Vêtements',
    Icons.dry_cleaning_outlined,
  ),
  ChecklistIconOption('Accessoires', 'Vêtements', Icons.shopping_bag_outlined),

  ChecklistIconOption('Avion', 'Voyage', Icons.flight_outlined),
  ChecklistIconOption(
    'Avion (contour)',
    'Voyage',
    const IconData(0xebb0, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Départ', 'Voyage', Icons.flight_takeoff),
  ChecklistIconOption('Arrivée', 'Voyage', Icons.flight_land),
  ChecklistIconOption('Valise', 'Voyage', Icons.luggage_outlined),
  ChecklistIconOption('Découverte', 'Voyage', Icons.travel_explore),
  ChecklistIconOption('Carte', 'Voyage', Icons.map_outlined),
  ChecklistIconOption('Explorer', 'Voyage', Icons.explore_outlined),
  ChecklistIconOption('Voiture', 'Voyage', Icons.directions_car_outlined),
  ChecklistIconOption(
    'Voiture (contour)',
    'Voyage',
    const IconData(0xec48, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Bus', 'Voyage', Icons.directions_bus_outlined),
  ChecklistIconOption('Train', 'Voyage', Icons.train_outlined),
  ChecklistIconOption('Métro', 'Voyage', Icons.subway_outlined),
  ChecklistIconOption('Hôtel', 'Voyage', Icons.hotel_outlined),
  ChecklistIconOption('Plage', 'Voyage', Icons.beach_access_outlined),
  ChecklistIconOption('Randonnée', 'Voyage', Icons.hiking),
  ChecklistIconOption('Photos', 'Voyage', Icons.photo_camera_outlined),
  ChecklistIconOption('Taxi', 'Voyage', FontAwesomeIcons.taxi.data),

  ChecklistIconOption('Passeport', 'Objets de voyage', Icons.badge_outlined),
  ChecklistIconOption(
    'Billet et réservation',
    'Objets de voyage',
    Icons.confirmation_number_outlined,
  ),
  ChecklistIconOption('Sac à dos', 'Objets de voyage', Icons.backpack_outlined),
  ChecklistIconOption('Gourde', 'Objets de voyage', Icons.water_drop_outlined),
  ChecklistIconOption('Parapluie', 'Objets de voyage', Icons.umbrella_outlined),
  ChecklistIconOption(
    'Trousse de toilette',
    'Objets de voyage',
    FontAwesomeIcons.shower.data,
  ),
  ChecklistIconOption(
    'Chargeur',
    'Objets de voyage',
    Icons.charging_station_outlined,
  ),
  ChecklistIconOption(
    'Adaptateur électrique',
    'Objets de voyage',
    Icons.electrical_services_outlined,
  ),
  ChecklistIconOption('Clés de voyage', 'Objets de voyage', Icons.key_outlined),
  ChecklistIconOption(
    'Carte bancaire',
    'Objets de voyage',
    Icons.credit_card_outlined,
  ),
  ChecklistIconOption(
    'Documents',
    'Objets de voyage',
    Icons.folder_open_outlined,
  ),
  ChecklistIconOption(
    'Porte-documents',
    'Objets de voyage',
    const IconData(0xec1a, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption(
    'Médicaments',
    'Objets de voyage',
    Icons.medication_outlined,
  ),
  ChecklistIconOption('Mouchoirs', 'Objets de voyage', Icons.waves_outlined),
  ChecklistIconOption('Camping', 'Objets de voyage', Icons.cabin_outlined),

  ChecklistIconOption('Fruits et légumes', 'Nourriture', Icons.eco_outlined),
  ChecklistIconOption('Petit-déjeuner', 'Nourriture', Icons.breakfast_dining),
  ChecklistIconOption('Déjeuner', 'Nourriture', Icons.lunch_dining),
  ChecklistIconOption('Dîner', 'Nourriture', Icons.dinner_dining),
  ChecklistIconOption('Pain et boulangerie', 'Nourriture', Icons.bakery_dining),
  ChecklistIconOption('Œufs', 'Nourriture', Icons.egg_alt_outlined),
  ChecklistIconOption('Repas', 'Nourriture', Icons.set_meal_outlined),
  ChecklistIconOption('Nouilles et soupe', 'Nourriture', Icons.ramen_dining),
  ChecklistIconOption('Riz', 'Nourriture', Icons.rice_bowl_outlined),
  ChecklistIconOption('Pizza', 'Nourriture', Icons.local_pizza_outlined),
  ChecklistIconOption('Sandwich', 'Nourriture', Icons.fastfood_outlined),
  ChecklistIconOption('Café', 'Nourriture', Icons.local_cafe_outlined),
  ChecklistIconOption(
    'Tasse de café',
    'Nourriture',
    const IconData(0xec7e, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Boisson', 'Nourriture', Icons.local_drink_outlined),
  ChecklistIconOption('Eau', 'Nourriture', Icons.water_drop_outlined),
  ChecklistIconOption('Glace', 'Nourriture', Icons.icecream_outlined),
  ChecklistIconOption('Gâteau', 'Nourriture', Icons.cake_outlined),
  ChecklistIconOption('Barbecue', 'Nourriture', Icons.outdoor_grill_outlined),
  ChecklistIconOption('Épicerie', 'Nourriture', Icons.shopping_basket_outlined),
  ChecklistIconOption(
    'Courses alimentaires',
    'Nourriture',
    Icons.shopping_cart_outlined,
  ),

  ChecklistIconOption('Maison', 'Maison', Icons.home_outlined),
  ChecklistIconOption(
    'Maison (contour)',
    'Maison',
    const IconData(0xe97b, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Clés', 'Maison', Icons.key_outlined),
  ChecklistIconOption('Porte', 'Maison', FontAwesomeIcons.doorClosed.data),
  ChecklistIconOption('Nettoyage', 'Maison', Icons.cleaning_services_outlined),
  ChecklistIconOption(
    'Lessive',
    'Maison',
    Icons.local_laundry_service_outlined,
  ),
  ChecklistIconOption('Meubles', 'Maison', Icons.chair_outlined),
  ChecklistIconOption('Literie', 'Maison', Icons.bed_outlined),
  ChecklistIconOption('Éclairage', 'Maison', Icons.lightbulb_outline),
  ChecklistIconOption(
    'Ampoule (contour)',
    'Maison',
    const IconData(0xe92a, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Eau', 'Maison', Icons.water_drop_outlined),
  ChecklistIconOption('Électricité', 'Maison', Icons.power_outlined),
  ChecklistIconOption('Jardin', 'Maison', Icons.yard_outlined),
  ChecklistIconOption('Sécurité', 'Maison', Icons.lock_outline),
  ChecklistIconOption('Climatisation', 'Maison', Icons.thermostat_outlined),
  ChecklistIconOption('Recyclage', 'Maison', Icons.recycling_outlined),
  ChecklistIconOption('Plante', 'Maison', FontAwesomeIcons.leaf.data),
  ChecklistIconOption('Douche', 'Maison', FontAwesomeIcons.shower.data),

  ChecklistIconOption('Santé', 'Santé', Icons.health_and_safety_outlined),
  ChecklistIconOption('Médical', 'Santé', Icons.medical_services_outlined),
  ChecklistIconOption('Médicaments', 'Santé', Icons.medication_outlined),
  ChecklistIconOption('Cœur', 'Santé', Icons.monitor_heart_outlined),
  ChecklistIconOption(
    'Cœur (contour)',
    'Santé',
    const IconData(0xe97a, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Vaccin', 'Santé', Icons.vaccines_outlined),
  ChecklistIconOption('Hôpital', 'Santé', Icons.local_hospital_outlined),
  ChecklistIconOption('Urgence', 'Santé', Icons.emergency_outlined),
  ChecklistIconOption('Accessibilité', 'Santé', Icons.accessibility_new),
  ChecklistIconOption('Bien-être', 'Santé', Icons.self_improvement),
  ChecklistIconOption('Sport', 'Santé', Icons.fitness_center),
  ChecklistIconOption(
    'Trousse médicale',
    'Santé',
    FontAwesomeIcons.suitcaseMedical.data,
  ),
  ChecklistIconOption(
    'Premiers soins',
    'Santé',
    FontAwesomeIcons.truckMedical.data,
  ),

  ChecklistIconOption('Téléphone', 'Technologie', Icons.smartphone_outlined),
  ChecklistIconOption(
    'Téléphone (contour)',
    'Technologie',
    const IconData(0xe9af, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Mobile', 'Technologie', Icons.phone_android),
  ChecklistIconOption('Ordinateur', 'Technologie', Icons.laptop_mac_outlined),
  ChecklistIconOption('Écran', 'Technologie', Icons.computer_outlined),
  ChecklistIconOption('Écouteurs', 'Technologie', Icons.headphones_outlined),
  ChecklistIconOption('Batterie', 'Technologie', Icons.battery_charging_full),
  ChecklistIconOption(
    'Éclair',
    'Technologie',
    const IconData(0xecfa, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Wi-Fi', 'Technologie', Icons.wifi),
  ChecklistIconOption('Routeur', 'Technologie', Icons.router_outlined),
  ChecklistIconOption(
    'Appareil photo',
    'Technologie',
    Icons.camera_alt_outlined,
  ),
  ChecklistIconOption('Câble', 'Technologie', Icons.cable_outlined),
  ChecklistIconOption('Montre', 'Technologie', Icons.watch_outlined),
  ChecklistIconOption('Bluetooth', 'Technologie', Icons.bluetooth_outlined),
  ChecklistIconOption(
    'Prise',
    'Technologie',
    Icons.electrical_services_outlined,
  ),
  ChecklistIconOption('Carte mémoire', 'Technologie', Icons.sd_card_outlined),

  ChecklistIconOption('Personne', 'Famille', Icons.person_outline),
  ChecklistIconOption(
    'Personne (contour)',
    'Famille',
    const IconData(0xe9aa, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Famille', 'Famille', Icons.family_restroom_outlined),
  ChecklistIconOption('Enfant', 'Famille', Icons.child_care_outlined),
  ChecklistIconOption('École', 'Famille', Icons.school_outlined),
  ChecklistIconOption('Sac à dos', 'Famille', Icons.backpack_outlined),
  ChecklistIconOption('Groupe', 'Famille', Icons.groups_outlined),
  ChecklistIconOption('Contacts', 'Famille', Icons.contacts_outlined),
  ChecklistIconOption('Animal', 'Famille', Icons.pets_outlined),
  ChecklistIconOption(
    'Chaussures enfant',
    'Famille',
    FontAwesomeIcons.socks.data,
  ),
  ChecklistIconOption('Badge', 'Famille', Icons.badge_outlined),

  ChecklistIconOption('Football', 'Loisirs', Icons.sports_soccer_outlined),
  ChecklistIconOption('Basket', 'Loisirs', Icons.sports_basketball_outlined),
  ChecklistIconOption('Vélo', 'Loisirs', Icons.directions_bike_outlined),
  ChecklistIconOption('Piscine', 'Loisirs', Icons.pool_outlined),
  ChecklistIconOption('Musique', 'Loisirs', Icons.music_note_outlined),
  ChecklistIconOption(
    'Note de musique',
    'Loisirs',
    const IconData(0xe99c, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Film', 'Loisirs', Icons.movie_outlined),
  ChecklistIconOption('Lecture', 'Loisirs', Icons.menu_book_outlined),
  ChecklistIconOption('Peinture', 'Loisirs', Icons.palette_outlined),
  ChecklistIconOption('Dessin', 'Loisirs', Icons.brush_outlined),
  ChecklistIconOption('Camping', 'Loisirs', Icons.cabin_outlined),
  ChecklistIconOption('Parc', 'Loisirs', Icons.park_outlined),
  ChecklistIconOption('Célébration', 'Loisirs', Icons.celebration_outlined),
  ChecklistIconOption('Jeu vidéo', 'Loisirs', Icons.sports_esports_outlined),
  ChecklistIconOption('Cadeau', 'Loisirs', Icons.card_giftcard_outlined),
  ChecklistIconOption(
    'Cadeau (contour)',
    'Loisirs',
    const IconData(0xe971, fontFamily: 'EvaIcons', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Restaurant', 'Loisirs', Icons.restaurant_outlined),

  ChecklistIconOption('Travail', 'Travail', Icons.work_outline),
  ChecklistIconOption('Bureau', 'Travail', Icons.business_center_outlined),
  ChecklistIconOption(
    'Porte-documents (contour)',
    'Travail',
    const IconData(0xec1a, fontFamily: 'Iconsax', fontPackage: 'icons_plus'),
  ),
  ChecklistIconOption('Outils', 'Travail', Icons.build_outlined),
];

class ChecklistIconPickerDialog extends StatefulWidget {
  const ChecklistIconPickerDialog({super.key});

  @override
  State<ChecklistIconPickerDialog> createState() =>
      _ChecklistIconPickerDialogState();
}

class _ChecklistIconPickerDialogState extends State<ChecklistIconPickerDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _activeCategory = 'Tout';
  String _query = '';

  List<String> get _categories => [
    'Tout',
    ...checklistIconOptions.map((option) => option.category).toSet(),
  ];

  List<ChecklistIconOption> get _filteredOptions {
    final query = _normalize(_query);
    return checklistIconOptions
        .where((option) {
          final matchesCategory =
              _activeCategory == 'Tout' || option.category == _activeCategory;
          final matchesQuery =
              query.isEmpty ||
              _normalize(option.label).contains(query) ||
              _normalize(option.category).contains(query);
          return matchesCategory && matchesQuery;
        })
        .toList(growable: false);
  }

  String _normalize(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp('[àáâä]'), 'a')
        .replaceAll(RegExp('[èéêë]'), 'e')
        .replaceAll(RegExp('[ìíîï]'), 'i')
        .replaceAll(RegExp('[òóôö]'), 'o')
        .replaceAll(RegExp('[ùúûü]'), 'u')
        .replaceAll('ç', 'c');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final dialogWidth = (screenSize.width - 48).clamp(280.0, 560.0);
    final dialogHeight = (screenSize.height - 180).clamp(300.0, 560.0);
    final options = _filteredOptions;

    return AlertDialog(
      title: const Text('Choisir une icône'),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      content: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Rechercher une icône',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Effacer la recherche',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return ChoiceChip(
                    label: Text(category),
                    selected: category == _activeCategory,
                    onSelected: (_) =>
                        setState(() => _activeCategory = category),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: options.isEmpty
                  ? const Center(child: Text('Aucune icône trouvée'))
                  : GridView.builder(
                      itemCount: options.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 76,
                            mainAxisExtent: 76,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                      itemBuilder: (context, index) {
                        final option = options[index];
                        return IconButton.filledTonal(
                          tooltip: '${option.label} · ${option.category}',
                          onPressed: () =>
                              Navigator.of(context).pop(option.icon),
                          icon: ChecklistIconView(icon: option.icon),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
      ],
    );
  }
}

Future<dynamic> showChecklistIconPicker(BuildContext context) {
  return showDialog<dynamic>(
    context: context,
    builder: (_) => const ChecklistIconPickerDialog(),
  );
}
