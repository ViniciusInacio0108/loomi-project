import 'package:flutter/material.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_viemwodel.dart';
import 'package:provider/provider.dart';

class MaintainConnected extends StatelessWidget {
  const MaintainConnected({super.key});

  @override
  Widget build(BuildContext context) {
    final isMaintainConnectedActive =
        context.watch<LoginAndSignupViewmodel>().isMaintainConnectedActive;

    return Row(
      children: [
        Checkbox(
          value: isMaintainConnectedActive,
          onChanged: (value) {
            context
                .read<LoginAndSignupViewmodel>()
                .onClickCheckboxMaintainConnected();
          },
        ),
        const Text('Mantenha-me conectado'),
      ],
    );
  }
}
