// lib/features/icons/di/icon_injection.dart
import 'package:get_it/get_it.dart';

import '../data/datasources/icon_local_data_source.dart';
import '../data/repositories/icon_repository_impl.dart';
import '../domain/repositories/icon_repository.dart';
import '../domain/usecases/get_dynamic_icons_use_case.dart';
import '../presentation/bloc/icon_bloc.dart';

final GetIt iconGetIt = GetIt.instance;

void configureIconDependencies() {
  iconGetIt.registerLazySingleton<IconLocalDataSource>(
    () => IconLocalDataSourceImpl(),
  );
  iconGetIt.registerLazySingleton<IconRepository>(
    () => IconRepositoryImpl(iconGetIt<IconLocalDataSource>()),
  );
  iconGetIt.registerLazySingleton(
    () => GetDynamicIconsUseCase(iconGetIt<IconRepository>()),
  );
  iconGetIt.registerFactory(
    () => IconBloc(iconGetIt<GetDynamicIconsUseCase>()),
  );
}
