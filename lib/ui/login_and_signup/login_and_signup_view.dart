import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loomi_project/config/routing/routes.dart';
import 'package:loomi_project/main.dart';
import 'package:loomi_project/ui/core/theme/app_colors.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_viemwodel.dart';
import 'package:loomi_project/ui/login_and_signup/widgets/bottom_buttons.dart';
import 'package:loomi_project/ui/login_and_signup/widgets/form_login_and_signup.dart';
import 'package:loomi_project/ui/login_and_signup/widgets/state_selector.dart';
import 'package:loomi_project/utils/constants/assets_path.dart';
import 'package:provider/provider.dart';

class LoginAndSignupView extends StatefulWidget {
  const LoginAndSignupView({super.key});

  @override
  State<LoginAndSignupView> createState() => _LoginAndSignupViewState();
}

class _LoginAndSignupViewState extends State<LoginAndSignupView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<LoginAndSignupViewmodel>().autoAuth().then(
          (isLoggedIn) {
            if (isLoggedIn) {
              Navigator.pushReplacementNamed(context, MyRoutes.HOME_PAGE);
            }
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sidePadding = MediaQuery.sizeOf(context).width * .05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 9.3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: sidePadding),
                child: SvgPicture.asset(LOGO_BLUE_PATH),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 15,
              left: MediaQuery.of(context).size.width / 7,
              child: Image.asset(
                LOGO_BG_PATH,
                color: Colors.black.withOpacity(.1),
                width: MediaQuery.of(context).size.width / 0.85,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: MyAppColors.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: const Offset(
                        0,
                        -25,
                      ),
                      child: const StateSelector(),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sidePadding),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        .015,
                                  ),
                                  const FormLoginAndSignup(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.sizeOf(context).height *
                                          .03,
                                      bottom:
                                          MediaQuery.paddingOf(context).bottom,
                                    ),
                                    child: const BottomButtons(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
