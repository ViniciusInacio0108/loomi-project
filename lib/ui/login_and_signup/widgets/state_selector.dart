import 'package:flutter/material.dart';
import 'package:loomi_project/ui/core/theme/app_colors.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_viemwodel.dart';
import 'package:loomi_project/ui/login_and_signup/widgets/form_login_and_signup.dart';
import 'package:provider/provider.dart';

class StateSelector extends StatelessWidget {
  const StateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isAccessAccountSelected =
        context.watch<LoginAndSignupViewmodel>().currentViewState ==
            LoginAndSignupViewState.LOGIN;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      height: 56,
      child: Container(
        decoration: const BoxDecoration(
          color: MyAppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: context
                      .read<LoginAndSignupViewmodel>()
                      .onPressedAccessAccount,
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    backgroundColor: isAccessAccountSelected
                        ? MyAppColors.primary
                        : MyAppColors.white,
                    foregroundColor: !isAccessAccountSelected
                        ? MyAppColors.black
                        : MyAppColors.white,
                  ),
                  child: const Text('Acessar conta'),
                ),
              ),
              Expanded(
                child: FilledButton(
                  onPressed: context
                      .read<LoginAndSignupViewmodel>()
                      .onPressedNoAccount,
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    backgroundColor: !isAccessAccountSelected
                        ? MyAppColors.primary
                        : MyAppColors.white,
                    foregroundColor: isAccessAccountSelected
                        ? MyAppColors.black
                        : MyAppColors.white,
                  ),
                  child: const Text(
                    'Não tenho conta',
                    textScaler: TextScaler.linear(.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
