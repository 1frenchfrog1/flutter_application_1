// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'checklist_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class ChecklistLocalizationsEs extends ChecklistLocalizations {
  ChecklistLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get retry => 'Reintentar';

  @override
  String get todoTitle => 'Título';

  @override
  String get description => 'Descripción';

  @override
  String get notes => 'Notas';

  @override
  String get tools => 'Herramientas';

  @override
  String get all => 'Todas';

  @override
  String get leftToDo => 'Pendientes';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get homeTooltip => 'Inicio';

  @override
  String get myChecklists => 'Mis listas de control';

  @override
  String get unableToLoadChecklists => 'No se pudieron cargar las listas de control';

  @override
  String get evaluationTools => 'Herramientas de evaluación';

  @override
  String get reload => 'Recargar';

  @override
  String get addChecklist => 'Añadir lista de control';

  @override
  String get evaluationPanel => 'Panel de evaluación';

  @override
  String get back => 'Volver';

  @override
  String get addSampleChecklists => 'Añadir listas de ejemplo';

  @override
  String get reloadFromStorage => 'Volver a cargar del almacenamiento';

  @override
  String get deleteAllChecklists => 'Eliminar todas las listas';

  @override
  String get editChecklist => 'Editar lista de control';

  @override
  String get otherActions => 'Más acciones';

  @override
  String get duplicate => 'Duplicar';

  @override
  String get uncheckAll => 'Desmarcar todo';

  @override
  String get checklistName => 'Nombre de la lista';

  @override
  String get checklistNameHint => 'P. ej., preparar un viaje';

  @override
  String get checklistNameRequired => 'Escribe un nombre para esta lista.';

  @override
  String get checkpoints => 'Puntos de control';

  @override
  String get manageCheckpoints => 'Gestionar puntos de control';

  @override
  String checkpointCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count puntos',
      one: '1 punto',
      zero: 'Ningún punto',
    );
    return '$_temp0';
  }

  @override
  String get iconChoice => 'Elegir icono';

  @override
  String get icon => 'Icono';

  @override
  String get chooseChecklistIcon => 'Elige un icono para la lista';

  @override
  String get checklistDescriptionHint => '¿Para qué sirve esta lista?';

  @override
  String get optionalNotes => 'Notas opcionales';

  @override
  String get saveChecklist => 'Guardar lista';

  @override
  String get deleteChecklistConfirmation => '¿Eliminar esta lista?';

  @override
  String get irreversibleAction => 'Esta acción es permanente.';

  @override
  String get editCheckpoint => 'Editar punto';

  @override
  String get editCheckpointTooltip => 'Editar punto de control';

  @override
  String get removeCheckpoint => 'Quitar punto de control';

  @override
  String get addCheckpoint => 'Añadir punto de control';

  @override
  String get deleteCheckpointConfirmation => '¿Eliminar este punto de control?';

  @override
  String get cannotUndo => 'Esta acción no se puede deshacer.';

  @override
  String get checkpointTitleRequired => 'Escribe un título para este punto.';

  @override
  String get checkpointIcon => 'Icono del punto de control';

  @override
  String get chooseIcon => 'Elegir un icono';

  @override
  String get iconWillAppearInList => 'Aparecerá en la lista';

  @override
  String get photo => 'Foto';

  @override
  String get noPhotoAdded => 'No se ha añadido ninguna foto';

  @override
  String get addPhoto => 'Añadir foto';

  @override
  String get replace => 'Reemplazar';

  @override
  String get removePhoto => 'Quitar foto';

  @override
  String get usefulDetails => 'Detalles útiles';

  @override
  String get saving => 'Guardando…';

  @override
  String get photoSaveError => 'No se pudo guardar la foto.';

  @override
  String get selectImageSource => 'Seleccionar origen de la imagen';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get selectCheckpointImage => 'Seleccionar imagen del punto';

  @override
  String get nothingSelected => 'No se ha seleccionado ninguna imagen';

  @override
  String get chooseImage => 'Elegir imagen';

  @override
  String get select => 'Seleccionar';

  @override
  String notesLabel(String notes) {
    return 'Notas: $notes';
  }

  @override
  String get allCategories => 'Todas';

  @override
  String get categoryEssential => 'Esenciales';

  @override
  String get categoryFamily => 'Familia';

  @override
  String get categoryLeisure => 'Ocio';

  @override
  String get categoryWeather => 'Clima';

  @override
  String get categoryHome => 'Hogar';

  @override
  String get categoryFood => 'Comida';

  @override
  String get categoryTravelItems => 'Artículos de viaje';

  @override
  String get categoryHealth => 'Salud';

  @override
  String get categoryTechnology => 'Tecnología';

  @override
  String get categoryWork => 'Trabajo';

  @override
  String get categoryClothing => 'Ropa';

  @override
  String get categoryTravel => 'Viajes';

  @override
  String get passportExample => 'P. ej., pasaporte';

  @override
  String get noIconsFound => 'No se encontraron iconos';

  @override
  String get searchIcon => 'Buscar iconos';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get iconLoadingErrorTitle => 'Error de carga';

  @override
  String get close => 'Cerrar';

  @override
  String get checklistIconPickerTitle => 'Elegir un icono';
}
