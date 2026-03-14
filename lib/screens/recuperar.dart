import 'package:flutter/material.dart';

class Recuperar extends StatefulWidget {
  const Recuperar({super.key});

  @override
  State<Recuperar> createState() => _RecuperarState();
}

class _RecuperarState extends State<Recuperar> {

  final TextEditingController emailController = TextEditingController();

  void recuperarCuenta() {

    String email = emailController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa tu correo"),
        ),
      );
      return;
    }

    /// Aquí luego conectarías con tu API PHP
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Continuando recuperación..."),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Recuperar Contraseña"),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Recuperar Contraseña",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Ingresa tu correo para recuperar tu cuenta",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Correo electrónico",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: recuperarCuenta,
                  child: const Text("Continuar"),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("← Volver al inicio de sesión"),
              )
            ],
          ),
        ),
      ),
    );
  }
}