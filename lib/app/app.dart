import 'package:assignment/app/controller_binder.dart';
import 'package:assignment/features/auth/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
