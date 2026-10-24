// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Todo List';

  @override
  String get home => 'Inicio';

  @override
  String get openTodoList => 'Abrir mi lista de tareas';

  @override
  String get openChecklists => 'Abrir mis listas de control';

  @override
  String get openIconCatalog => 'Abrir el catálogo de iconos';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get loadingLanguage => 'Cargando idioma…';

  @override
  String get languageLoadError => 'No se pudo cargar el idioma guardado.';

  @override
  String get languageSaveError =>
      'No se pudo guardar el idioma. La selección no se conservará al reiniciar la aplicación.';

  @override
  String get continueInFrench => 'Continuar en francés';

  @override
  String get retry => 'Reintentar';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageGerman => 'Deutsch';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get myTodoList => 'Mi lista de tareas';

  @override
  String get editTodo => 'Editar tarea';

  @override
  String get addTodo => 'Añadir tarea';

  @override
  String get todoTitle => 'Título';

  @override
  String get description => 'Descripción';

  @override
  String get todoDetails => 'Detalles de la tarea';

  @override
  String get deleteCompletedTodos => 'Eliminar tareas completadas';

  @override
  String get todoDeleted => 'Tarea eliminada';

  @override
  String get undo => 'Deshacer';

  @override
  String get tools => 'Herramientas';

  @override
  String get all => 'Todas';

  @override
  String get leftToDo => 'Pendientes';

  @override
  String openTaskCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tareas pendientes',
      one: '1 tarea pendiente',
      zero: 'No hay tareas pendientes',
    );
    return '$_temp0';
  }

  @override
  String get todoPoints => 'Puntos pendientes';

  @override
  String get emptyTodoDescription => 'Esta tarea no tiene contenido.';

  @override
  String get emptyTodoTitle => 'Todo está al día';

  @override
  String get emptyTodoMessage => 'Añade una tarea para empezar.';

  @override
  String get todoTitleRequired => 'El título no puede estar vacío.';

  @override
  String get save => 'Guardar';

  @override
  String get addTodoAction => 'Añadir tarea';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get modify => 'Editar';

  @override
  String get deleteTodoConfirmation => '¿Eliminar esta tarea?';

  @override
  String deleteTodoConfirmationContent(String title) {
    return 'La tarea «$title» se eliminará definitivamente.';
  }

  @override
  String get homeTooltip => 'Inicio';

  @override
  String get toolsTooltip => 'Herramientas';

  @override
  String get icon => 'Icono';

  @override
  String get iconCatalog => 'Catálogo de iconos';

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
  String get noIconsLoaded => 'No se ha cargado ningún icono.';

  @override
  String iconLoadError(String message) {
    return 'No se pudieron cargar los iconos: $message';
  }

  @override
  String get noIconsAvailable => 'No hay iconos disponibles.';

  @override
  String get close => 'Cerrar';
}
