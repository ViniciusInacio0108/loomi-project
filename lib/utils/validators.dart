mixin MyValidations {
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Digite sua senha';
    }

    if (!passwordRegex.hasMatch(password)) {
      return 'A senha deve ter ao menos 8 caracteres, com letras e números';
    }

    return null;
  }

  String? validateConfirmPassword({String? password, String? confirmPassword}) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Digite sua senha';
    }

    if (!passwordRegex.hasMatch(confirmPassword)) {
      return 'A senha deve ter ao menos 8 caracteres, com letras e números';
    }

    if (password != confirmPassword) {
      return 'As senhas precisam ser iguais!';
    }

    return null;
  }

  // this will be overwritten because the validation does not match with the API
  String? validateEmail(String? email) {
    return null;

    if (email == null || email.isEmpty) {
      return 'Digite seu e-mail';
    }

    if (!emailRegex.hasMatch(email)) {
      return 'Digite um e-mail válido (ex: usuario@dominio.com)';
    }

    return null;
  }
}
