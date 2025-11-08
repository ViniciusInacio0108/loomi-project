import 'package:flutter/material.dart';
import 'package:loomi_project/config/routing/routes.dart';
import 'package:loomi_project/ui/core/snackbar/top_snackbar.dart';
import 'package:loomi_project/ui/core/theme/app_colors.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_viemwodel.dart';
import 'package:loomi_project/ui/login_and_signup/widgets/maintain_connected.dart';
import 'package:loomi_project/utils/validators.dart';
import 'package:provider/provider.dart';

class FormLoginAndSignup extends StatefulWidget {
  const FormLoginAndSignup({super.key});

  @override
  State<FormLoginAndSignup> createState() => _FormLoginAndSignupState();
}

class _FormLoginAndSignupState extends State<FormLoginAndSignup>
    with MyValidations {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  Future<void> _onClickPrimaryButton() async {
    if (_formKey.currentState?.validate() == true) {
      await context
          .read<LoginAndSignupViewmodel>()
          .onClickLoginButton(
            _emailController.text,
            _passwordController.text,
          )
          .then(
        (authSuccess) {
          if (authSuccess) {
            _navigateHome();
          }
        },
      );
    }
  }

  void _navigateHome() {
    Navigator.pushReplacementNamed(context, MyRoutes.HOME_PAGE);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paddingBetweenFields = MediaQuery.sizeOf(context).height * .019;

    final currentViewState =
        context.watch<LoginAndSignupViewmodel>().currentViewState;

    final textActionButton = currentViewState == LoginAndSignupViewState.SIGNUP
        ? 'Cadastrar-se'
        : 'Entrar';

    return Consumer<LoginAndSignupViewmodel>(
        builder: (context, viewmodel, child) {
      if (viewmodel.authErrorMessage != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          TopSnackBar.show(
            context,
            title: 'Algo deu errado!',
            message: viewmodel.authErrorMessage!,
            type: TopSnackBarType.ERROR,
          );

          viewmodel.clearErrorMessage();
        });
      }

      return Container(
        decoration: BoxDecoration(
          color: MyAppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    context
                        .read<LoginAndSignupViewmodel>()
                        .onChangedEmailTextField(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Digite seu E-mail',
                  ),
                ),
                if (context
                        .watch<LoginAndSignupViewmodel>()
                        .isShowingMaintainConnected ||
                    context.watch<LoginAndSignupViewmodel>().currentViewState ==
                        LoginAndSignupViewState.SIGNUP)
                  Padding(
                    padding: EdgeInsets.only(top: paddingBetweenFields),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: validatePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        labelText: 'Digite a senha',
                      ),
                    ),
                  ),
                if (currentViewState == LoginAndSignupViewState.SIGNUP)
                  Padding(
                    padding: EdgeInsets.only(top: paddingBetweenFields),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      validator: (value) {
                        return validateConfirmPassword(
                            password: _passwordController.text,
                            confirmPassword: value);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Confirme a senha',
                      ),
                    ),
                  ),
                if (context
                        .watch<LoginAndSignupViewmodel>()
                        .isShowingMaintainConnected &&
                    context.watch<LoginAndSignupViewmodel>().currentViewState ==
                        LoginAndSignupViewState.LOGIN)
                  const MaintainConnected(),
                SizedBox(height: paddingBetweenFields),
                (!context.watch<LoginAndSignupViewmodel>().isAuthenticating)
                    ? FilledButton(
                        onPressed: () async {
                          await _onClickPrimaryButton();
                        },
                        child: Text(textActionButton),
                      )
                    : const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
