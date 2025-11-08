import 'package:loomi_project/domain/repositories/auth_repository.dart';

class SetMaintainConnectedUseCase {
  final AuthRepository authRepo;

  SetMaintainConnectedUseCase({
    required this.authRepo,
  });

  Future<void> call(bool value) async {
    await authRepo.updateMaintainConnected(value);
  }
}
