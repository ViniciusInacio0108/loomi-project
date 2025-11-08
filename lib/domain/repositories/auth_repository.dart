import 'package:result_dart/result_dart.dart';

abstract class AuthRepository {
  Future<Result<String>> authenticate(String username, String password);
  Future<Result<String>> autoAuth();
  Future<void> updateMaintainConnected(bool value);
  Future<bool?> fetchMaintainConnected();
}
