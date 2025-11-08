import 'package:result_dart/result_dart.dart';

import 'package:loomi_project/domain/repositories/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepo;

  AuthUsecase({
    required this.authRepo,
  });

  Future<Result<String>> call(String username, String password) async {
    return await authRepo.authenticate(username, password);
  }
}
