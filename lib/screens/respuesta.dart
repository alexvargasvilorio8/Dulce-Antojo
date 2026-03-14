import 'package:flutter/material.dart';

class Respuesta extends StatefulWidget {
  final String pregunta;

  const Respuesta({
    super.key,
    required this.pregunta,
  });

  @override
  State<Respuesta> createState() => _RespuestaScreenState();
}

class _RespuestaScreenState extends State<Respuesta> {
  final TextEditingController respuestaController = TextEditingController();

  void validarRespuesta() {
    final respuesta = respuestaController.text.trim();

    if (respuesta.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Escribe tu respuesta"),
        ),
      );
      return;
    }

    // Aquí luego conectarías con:
    // php/verificar_respuesta.php

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Respuesta validada"),
      ),
    );
  }

  @override
  void dispose() {
    respuestaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pregunta de Seguridad"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pregunta de Seguridad",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tu pregunta de seguridad:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.pregunta,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: respuestaController,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: "Respuesta",
                    hintText: "Escribe tu respuesta aquí",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validarRespuesta,
                  child: const Text("Validar Respuesta"),
                ),
                const SizedBox(height: 12),
                const Text(
                  "La respuesta distingue mayúsculas y minúsculas",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("← Regresar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}