import 'package:flutter/material.dart';
import 'package:loomi_project/config/dependency_injection/main_injector.dart';
import 'package:loomi_project/config/routing/routes.dart';
import 'package:loomi_project/ui/core/theme/app_theme.dart';
import 'package:loomi_project/ui/login_and_signup/login_and_signup_viemwodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => getIt.get<LoginAndSignupViewmodel>(),
        )
      ],
      child: MaterialApp(
        title: 'Loomi Project',
        theme: MyThemeData().themeData,
        routes: MyRoutes.routes,
      ),
    );
  }
}
