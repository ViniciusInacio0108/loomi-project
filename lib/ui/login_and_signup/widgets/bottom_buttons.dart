import 'package:flutter/material.dart';
import 'package:loomi_project/ui/core/theme/app_colors.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: MyAppColors.white,
          ),
          child: const Text(
            'Esqueci a senha',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: MyAppColors.white,
            ),
          ),
        ),
        const Text(
          '•',
          style: TextStyle(color: MyAppColors.white),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: MyAppColors.white,
          ),
          child: const Text(
            'Continuar sem conta',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: MyAppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
