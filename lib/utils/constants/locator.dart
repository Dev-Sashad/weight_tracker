import 'package:get_it/get_it.dart';
import 'package:weight_traker/core/services/auth_service.dart';
import 'package:weight_traker/core/services/firestoreServices.dart';
import 'package:weight_traker/utils/dialogeManager/dialogService.dart';
import 'package:weight_traker/utils/router/navigationService.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProgressService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FireStoreService());
}
