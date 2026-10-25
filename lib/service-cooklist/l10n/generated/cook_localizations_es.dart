// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'cook_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CookLocalizationsEs extends CookLocalizations {
  CookLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get myCooklists => 'Mis Cooklists';

  @override
  String get homeTooltip => 'Inicio';

  @override
  String get unableToLoadCooklists => 'No se pudieron cargar las cooklists';

  @override
  String get evaluationTools => 'Herramientas de evaluación';

  @override
  String get reload => 'Recargar';

  @override
  String get addCooklist => 'Añadir cooklist';

  @override
  String get evaluationPanel => 'Panel de evaluación';

  @override
  String get back => 'Volver';

  @override
  String get addSampleCooklists => 'Añadir recetas de ejemplo';

  @override
  String get reloadFromStorage => 'Recargar desde el almacenamiento';

  @override
  String get deleteAllCooklists => 'Eliminar todas las cooklists';

  @override
  String get editCooklist => 'Editar cooklist';

  @override
  String get otherActions => 'Más acciones';

  @override
  String get duplicate => 'Duplicar';

  @override
  String get uncheckAll => 'Desmarcar todo';

  @override
  String get cooklistName => 'Nombre de la receta';

  @override
  String get cooklistNameHint => 'Ej. Gratinado de patatas';

  @override
  String get cooklistNameRequired => 'Introduce un nombre para la receta.';

  @override
  String get steps => 'Pasos';

  @override
  String get manageSteps => 'Gestionar los pasos';

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pasos',
      one: '1 paso',
      zero: 'Ningún paso',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Elegir un icono';

  @override
  String get icon => 'Icono';

  @override
  String get chooseCooklistIcon => 'Elige un icono para la receta';

  @override
  String get cooklistDescriptionHint => '¿De qué trata esta receta?';

  @override
  String get optionalNotes => 'Notas opcionales';

  @override
  String get saveCooklist => 'Guardar cooklist';

  @override
  String get deleteCooklistConfirmation => '¿Eliminar esta cooklist?';

  @override
  String get irreversibleAction => 'Esta acción es definitiva.';

  @override
  String get editStep => 'Editar paso';

  @override
  String get editStepTooltip => 'Editar paso';

  @override
  String get removeStep => 'Quitar paso';

  @override
  String get addStep => 'Añadir paso';

  @override
  String get ingredients => 'Ingredientes';

  @override
  String get noIngredients => 'Sin ingredientes';

  @override
  String get editIngredients => 'Editar ingredientes';

  @override
  String get editIngredient => 'Editar ingrediente';

  @override
  String get addIngredient => 'Añadir ingrediente';

  @override
  String get removeIngredient => 'Quitar ingrediente';

  @override
  String get deleteIngredientConfirmation => '¿Eliminar este ingrediente?';

  @override
  String get ingredientName => 'Ingrediente';

  @override
  String get ingredientNameExample => 'Harina, nata, huevos…';

  @override
  String get ingredientNameRequired => 'Introduce el nombre del ingrediente';

  @override
  String get ingredientQuantity => 'Cantidad';

  @override
  String get ingredientQuantityInvalid => 'Introduce un número válido';

  @override
  String get ingredientUnit => 'Unidad';

  @override
  String get utensils => 'Utensilios y herramientas';

  @override
  String get noUtensils => 'Sin utensilios';

  @override
  String get editUtensils => 'Editar utensilios y herramientas';

  @override
  String get editUtensil => 'Editar utensilio';

  @override
  String get addUtensil => 'Añadir utensilio';

  @override
  String get removeUtensil => 'Quitar utensilio';

  @override
  String get deleteUtensilConfirmation => '¿Eliminar este utensilio?';

  @override
  String get utensilName => 'Utensilio o herramienta';

  @override
  String get utensilNameExample => 'Bol, horno, batidor…';

  @override
  String get utensilNameRequired => 'Introduce el nombre del utensilio';

  @override
  String get deleteStepConfirmation => '¿Eliminar este paso?';

  @override
  String get cannotUndo => 'Esta acción no se puede deshacer.';

  @override
  String get stepTitle => 'Título';

  @override
  String get stepTitleRequired => 'Introduce un título para este paso.';

  @override
  String get stepExample => 'Ej. Sofreír las cebollas';

  @override
  String get stepIcon => 'Icono del paso';

  @override
  String get chooseIcon => 'Elegir un icono';

  @override
  String get iconWillAppearInList => 'Aparecerá en la lista';

  @override
  String get photo => 'Foto';

  @override
  String get noPhotoAdded => 'Ninguna foto añadida';

  @override
  String get addPhoto => 'Añadir foto';

  @override
  String get replace => 'Reemplazar';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get description => 'Descripción';

  @override
  String get usefulDetails => 'Detalles útiles';

  @override
  String get notes => 'Notas';

  @override
  String notesLabel(String notes) {
    return 'Notas: $notes';
  }

  @override
  String get saving => 'Guardando…';

  @override
  String get photoSaveError => 'No se pudo guardar la foto.';

  @override
  String get selectImageSource => 'Seleccionar el origen de la imagen';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get selectStepImage => 'Seleccionar una imagen para el paso';

  @override
  String get nothingSelected => 'Ninguna imagen seleccionada';

  @override
  String get chooseImage => 'Elegir imagen';

  @override
  String get select => 'Seleccionar';

  @override
  String get tools => 'Herramientas';

  @override
  String get all => 'Todos';

  @override
  String get leftToDo => 'Por hacer';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get retry => 'Reintentar';

  @override
  String get close => 'Cerrar';

  @override
  String get iconLoadingErrorTitle => 'No se pudo cargar';

  @override
  String get cooklistIconPickerTitle => 'Elegir un icono';

  @override
  String get searchIcon => 'Buscar iconos';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get allCategories => 'Todos';

  @override
  String get noIconsFound => 'No se encontraron iconos';

  @override
  String get categoryEssential => 'Esenciales';

  @override
  String get categoryFamily => 'Familia';

  @override
  String get categoryLeisure => 'Ocio';

  @override
  String get categoryWeather => 'Tiempo';

  @override
  String get categoryHome => 'Casa';

  @override
  String get categoryFood => 'Comida';

  @override
  String get categoryTravelItems => 'Objetos de viaje';

  @override
  String get categoryHealth => 'Salud';

  @override
  String get categoryTechnology => 'Tecnología';

  @override
  String get categoryWork => 'Trabajo';

  @override
  String get categoryClothing => 'Ropa';

  @override
  String get categoryTravel => 'Viaje';
}
