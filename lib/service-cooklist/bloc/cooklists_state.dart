import '../datamodel/cook_list_data_model.dart';

abstract class CooklistsState {}

class CooklistsLoadInProgress extends CooklistsState {}

class CooklistsLoadSuccess extends CooklistsState {
  final List<CookList> cooklists;

  CooklistsLoadSuccess(List<CookList> cooklists)
    : cooklists = List.unmodifiable(cooklists);
}

class CooklistsLoadFailure extends CooklistsState {}
