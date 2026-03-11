import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final respuestaController = TextEditingController();

  String? preguntaSeleccionada;

  Future<void> registrarUsuario() async {

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Las contraseñas no coinciden"))
      );
      return;
    }

    var response = await http.post(
      Uri.parse("http://tuservidor/php/register.php"),
      body: {
        "nombre": nombreController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "pregunta": preguntaSeleccionada ?? "",
        "respuesta": respuestaController.text
      }
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cuenta creada correctamente"))
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Crear Cuenta"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Crear Cuenta",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre completo",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

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

            const SizedBox(height: 15),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirmar contraseña",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pregunta de seguridad",
              ),
              items: const [
                DropdownMenuItem(
                  value: "¿Cuál es el nombre de tu primera mascota?",
                  child: Text("¿Cuál es el nombre de tu primera mascota?"),
                ),
                DropdownMenuItem(
                  value: "¿En qué ciudad naciste?",
                  child: Text("¿En qué ciudad naciste?"),
                ),
                DropdownMenuItem(
                  value: "¿Cuál es tu comida favorita?",
                  child: Text("¿Cuál es tu comida favorita?"),
                ),
                DropdownMenuItem(
                  value: "¿Nombre de tu mejor amigo de la infancia?",
                  child: Text("¿Nombre de tu mejor amigo de la infancia?"),
                ),
              ],
              onChanged: (value) {
                preguntaSeleccionada = value;
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: respuestaController,
              decoration: const InputDecoration(
                labelText: "Tu respuesta",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: registrarUsuario,
                child: const Text("Crear Cuenta"),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿Ya tienes cuenta? "),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Iniciar sesión"),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
