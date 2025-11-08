import 'package:flutter/material.dart';

import 'package:loomi_project/domain/usecases/auth/auth_usecase.dart';
import 'package:loomi_project/domain/usecases/auth/auto_auth_usecase.dart';
import 'package:loomi_project/domain/usecases/auth/get_maintain_connected.dart';
import 'package:loomi_project/domain/usecases/auth/update_maintain_connected.dart';

enum LoginAndSignupViewState { LOGIN, SIGNUP }

class LoginAndSignupViewmodel with ChangeNotifier {
  final AuthUsecase authenticationUseCase;
  final AutoAuthUsecase autoAuthUseCase;
  final GetMaintainConnectedUseCase getMaintainConnectedUseCase;
  final SetMaintainConnectedUseCase setMaintainConnectedUseCase;

  LoginAndSignupViewmodel({
    required this.authenticationUseCase,
    required this.autoAuthUseCase,
    required this.getMaintainConnectedUseCase,
    required this.setMaintainConnectedUseCase,
  });

  LoginAndSignupViewState _currentViewState = LoginAndSignupViewState.LOGIN;

  LoginAndSignupViewState get currentViewState => _currentViewState;

  void onPressedAccessAccount() {
    _currentViewState = LoginAndSignupViewState.LOGIN;
    notifyListeners();
  }

  void onPressedNoAccount() {
    _currentViewState = LoginAndSignupViewState.SIGNUP;
    notifyListeners();
  }

  bool _isMaintainConnectedActive = false;

  bool get isMaintainConnectedActive => _isMaintainConnectedActive;

  Future<void> onClickCheckboxMaintainConnected() async {
    _isMaintainConnectedActive = !_isMaintainConnectedActive;
    _setMaintainConnectedLocally(_isMaintainConnectedActive);
    notifyListeners();
  }

  bool _isShowingMaintainConnected = false;

  bool get isShowingMaintainConnected => _isShowingMaintainConnected;

  bool _isAuthenticating = false;

  bool get isAuthenticating => _isAuthenticating;

  String? _authErroMessage;

  String? get authErrorMessage => _authErroMessage;

  void clearErrorMessage() {
    _authErroMessage = null;
    notifyListeners();
  }

  void onChangedEmailTextField(String value) {
    if (value.isEmpty) {
      _isShowingMaintainConnected = false;
    } else {
      _isShowingMaintainConnected = true;
    }
    notifyListeners();
  }

  Future<bool> onClickLoginButton(String username, String password) async {
    _isAuthenticating = true;
    notifyListeners();

    final authResult = await authenticationUseCase.call(username, password);

    _isAuthenticating = false;
    notifyListeners();

    return authResult.fold<bool>(
      (success) {
        return true;
      },
      (failure) {
        _authErroMessage = failure.toString();
        notifyListeners();
        return false;
      },
    );
  }

  Future<bool> _isMaintainConnectedActiveLocally() async {
    return await getMaintainConnectedUseCase.call();
  }

  Future<void> _setMaintainConnectedLocally(bool value) async {
    await setMaintainConnectedUseCase.call(value);
  }

  Future<bool> autoAuth() async {
    if (!await _isMaintainConnectedActiveLocally()) {
      return false;
    }

    final resultAutoAuth = await autoAuthUseCase.call();

    return resultAutoAuth.fold<bool>(
      (success) {
        return true;
      },
      (failure) {
        return false;
      },
    );
  }
}
