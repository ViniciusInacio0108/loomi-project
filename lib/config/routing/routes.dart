import 'package:flutter/material.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_view.dart';

class MyRoutes {
  static const LOGIN_PAGE = '/';
  static const HOME_PAGE = '/home';

  static final Map<String, Widget Function(BuildContext)> routes = {
    LOGIN_PAGE: (_) => const LoginAndSignupView(),
    // Mock home
    HOME_PAGE: (_) => const Scaffold(
          body: Center(child: Text('HOME!')),
        ),
  };
}
