class AuthService {
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      return {
        "success": false,
        "message": "Completa todos los campos",
      };
    }

    if (email == "admin@gmail.com" && password == "123456") {
      return {
        "success": true,
        "rol": "admin",
        "nombre": "Administrador",
      };
    }

    if (email == "cliente@gmail.com" && password == "123456") {
      return {
        "success": true,
        "rol": "cliente",
        "nombre": "Cliente",
      };
    }

    return {
      "success": false,
      "message": "Credenciales incorrectas",
    };
  }

  static bool checkLogin(bool logueado) {
    return logueado;
  }
}