import 'package:loomi_project/domain/repositories/auth_repository.dart';

class GetMaintainConnectedUseCase {
  final AuthRepository authRepo;

  GetMaintainConnectedUseCase({
    required this.authRepo,
  });

  Future<bool> call() async {
    return await authRepo.fetchMaintainConnected() ?? false;
  }
}
