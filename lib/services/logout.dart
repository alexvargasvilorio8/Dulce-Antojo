import 'package:flutter/material.dart';
import 'login.dart';

class LogoutService {

  static void logout(BuildContext context) {

    // Aquí luego puedes limpiar:
    // SharedPreferences
    // tokens
    // datos del usuario

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );

  }

}