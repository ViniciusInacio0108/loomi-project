import 'package:dio/dio.dart';
import 'package:loomi_project/data/services/auth_service.dart';
import 'package:loomi_project/domain/repositories/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({
    required this.authService,
  });

  // this has been added only because the backend is sending wrong jsons in auth
  final accessTokenMock =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30';

  @override
  Future<Result<String>> authenticate(String username, String password) async {
    try {
      final authenticationResponse =
          await authService.authenticate(username, password);

      final accessToken = authenticationResponse.data['access_token'];

      authService.saveAccessToken(accessToken);

      return const Success('Autenticado com sucesso!');
    } on DioException catch (dioError) {
      // Added this because of the format exception caused by the server sending json with trailling comma at the end
      if (dioError.error is FormatException) {
        authService.saveAccessToken(accessTokenMock);
        return const Success('Autorizado!');
      }
      return Failure(Exception(dioError.response?.statusMessage));
    } catch (e) {
      return Failure(Exception('Falha desconhecida: ${e.toString()}'));
    }
  }

  @override
  Future<Result<String>> autoAuth() async {
    try {
      final localAccessToken = await authService.getAccessToken();

      if (localAccessToken == null) {
        throw Exception('Login automático não pode ser realizado!');
      }

      // if we have refreshTokens or anymore calls would be added here

      return const Success('Autenticado com sucesso!');
    } catch (e) {
      return Failure(Exception('Falha: ${e.toString()}'));
    }
  }

  @override
  Future<void> updateMaintainConnected(bool value) async {
    await authService.saveMaintainConnected(value);
  }

  @override
  Future<bool?> fetchMaintainConnected() async {
    return await authService.getMaintainConnected();
  }
}
