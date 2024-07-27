import 'package:get_it/get_it.dart';
import 'package:something/utils/local_storage_service.dart';

GetIt locator = GetIt.instance;

setupLocator() async {
  final localStorage = await LocalStorageService().init();
  
  locator.registerLazySingleton<LocalStorageService>(() => localStorage);
}
