import 'package:flutter/material.dart';

class NuevaContrasena extends StatefulWidget {
  const NuevaContrasena({super.key});

  @override
  State<NuevaContrasena> createState() => _NuevaContrasenaState();
}

class _NuevaContrasenaState extends State<NuevaContrasena> {

  final TextEditingController nuevaController = TextEditingController();
  final TextEditingController confirmarController = TextEditingController();

  void guardarContrasena() {

    String nueva = nuevaController.text;
    String confirmar = confirmarController.text;

    if (nueva.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("La contraseña debe tener al menos 6 caracteres"),
        ),
      );
      return;
    }

    if (nueva != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Las contraseñas no coinciden"),
        ),
      );
      return;
    }

    /// Aquí iría la conexión con tu API PHP (guardar_nueva.php)

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Contraseña actualizada correctamente"),
      ),
    );

    /// regresar al login
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Nueva Contraseña"),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Column(
            children: [

              const Text(
                "🔑 Nueva Contraseña",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Ingresa tu nueva contraseña",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              TextField(
                controller: nuevaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Nueva contraseña",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: confirmarController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirmar contraseña",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: guardarContrasena,
                  child: const Text("Guardar Contraseña"),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "La contraseña debe tener al menos 6 caracteres",
                style: TextStyle(
                  color: Colors.grey
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("← Ir a iniciar sesión"),
              )

            ],
          ),
        ),
      ),
    );
  }
}