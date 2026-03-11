import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    // Aquí luego puedes enviar los datos a tu PHP
    print("Email: $email");
    print("Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dulce Antojo"),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Correo electrónico",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: login,
                    child: const Text("Iniciar Sesión"),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    // Ir a recuperar contraseña
                  },
                  child: const Text("¿Olvidaste tu contraseña?"),
                ),

                const SizedBox(height: 20),

                const Divider(),

                const Text("¿No tienes cuenta?"),

                TextButton(
                  onPressed: () {
                    // Ir a registro
                  },
                  child: const Text("Crear cuenta nueva"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}