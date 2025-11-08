import 'package:result_dart/result_dart.dart';

import 'package:loomi_project/domain/repositories/auth_repository.dart';

class AutoAuthUsecase {
  final AuthRepository authRepo;

  AutoAuthUsecase({
    required this.authRepo,
  });

  Future<Result<String>> call() async {
    return await authRepo.autoAuth();
  }
}
