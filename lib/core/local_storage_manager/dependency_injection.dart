import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_manager.dart';

void initiDependenciesCoreLocalStorageManager(SharedPreferences instance) {
  final _get = GetIt.instance;

  _get.registerLazySingleton<SharedPreferences>(() => instance);

  _get.registerLazySingleton<LocalStorageManager>(
    () => LocalStorageManagerImpl(
      _get(),
    ),
  );
}
