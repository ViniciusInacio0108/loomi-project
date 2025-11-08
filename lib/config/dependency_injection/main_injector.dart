import 'package:get_it/get_it.dart';
import 'package:loomi_project/config/clients/dio_client.dart';
import 'package:loomi_project/config/dependency_injection/auth_injector.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // This should be in a .env file for production
  const BASE_URL_LOOMI = 'https://flutter-challenge.wiremockapi.cloud';

  // clients
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: BASE_URL_LOOMI),
  );

  // dependencies
  setupAuthDependencies();
}
