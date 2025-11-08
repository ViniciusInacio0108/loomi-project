import 'package:loomi_project/config/clients/dio_client.dart';
import 'package:loomi_project/config/dependency_injection/main_injector.dart';
import 'package:loomi_project/data/repositories/auth_repository_impl.dart';
import 'package:loomi_project/data/services/auth_service.dart';
import 'package:loomi_project/domain/repositories/auth_repository.dart';
import 'package:loomi_project/domain/usecases/auth/auth_usecase.dart';
import 'package:loomi_project/domain/usecases/auth/auto_auth_usecase.dart';
import 'package:loomi_project/domain/usecases/auth/get_maintain_connected.dart';
import 'package:loomi_project/domain/usecases/auth/update_maintain_connected.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_viemwodel.dart';

Future<void> setupAuthDependencies() async {
  // services
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(
      getIt.get<DioClient>().dio,
    ),
  );

  // repos
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authService: getIt.get(),
    ),
  );

  // usecases
  getIt.registerLazySingleton<AuthUsecase>(
    () => AuthUsecase(
      authRepo: getIt.get(),
    ),
  );
  getIt.registerLazySingleton<GetMaintainConnectedUseCase>(
    () => GetMaintainConnectedUseCase(
      authRepo: getIt.get(),
    ),
  );
  getIt.registerLazySingleton<SetMaintainConnectedUseCase>(
    () => SetMaintainConnectedUseCase(
      authRepo: getIt.get(),
    ),
  );
  getIt.registerLazySingleton<AutoAuthUsecase>(
    () => AutoAuthUsecase(
      authRepo: getIt.get(),
    ),
  );

  // ViewModels
  getIt.registerLazySingleton<LoginAndSignupViewmodel>(
    () => LoginAndSignupViewmodel(
      authenticationUseCase: getIt.get(),
      getMaintainConnectedUseCase: getIt.get(),
      setMaintainConnectedUseCase: getIt.get(),
      autoAuthUseCase: getIt.get(),
    ),
  );
}
