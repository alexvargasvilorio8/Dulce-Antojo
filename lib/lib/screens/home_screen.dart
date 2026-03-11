import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final emailController = TextEditingController();
  final direccionController = TextEditingController();
  final pedidoController = TextEditingController();
  final comentariosController = TextEditingController();

  void enviarWhatsApp() async {

    String mensaje = """
Nombre: ${nombreController.text}
Teléfono: ${telefonoController.text}
Correo: ${emailController.text}
Dirección: ${direccionController.text}
Pedido: ${pedidoController.text}
Observaciones: ${comentariosController.text}
""";

    final url = Uri.parse(
        "https://wa.me/50432397033?text=${Uri.encodeComponent(mensaje)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Dulce Antojo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Mi Cuenta", style: TextStyle(color: Colors.white)),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// HERO
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Text(
                    "¡Endulza tu día con Dulce Antojo!",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Deléitate con nuestros postres artesanales elaborados con amor.",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            /// IMÁGENES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/carrotcupcake.jpg", width: 150),
                const SizedBox(width: 10),
                Image.asset("assets/images/cheesecakeslide.jpg", width: 150),
              ],
            ),

            const SizedBox(height: 30),

            /// ABOUT
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Sobre Nosotros",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      "Dulce Antojo nació del amor por hornear desde pequeña. "
                      "Aprendí observando a mi mamá, tías y abuelas crear postres deliciosos."),
                  const SizedBox(height: 10),
                  Image.asset("assets/images/logo.jpeg", width: 120),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// MENÚ (ejemplo simple)
            const Text(
              "Nuestro Menú",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                productCard("Cheesecake", 350, "assets/images/cheesecakeslide.jpg"),
                productCard("Carrot Cupcake", 120, "assets/images/carrotcupcake.jpg"),
              ],
            ),

            const SizedBox(height: 30),

            /// CONTACTO
            const Text(
              "Contáctanos",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),

                  TextField(
                    controller: telefonoController,
                    decoration: const InputDecoration(labelText: "Teléfono"),
                  ),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Correo"),
                  ),

                  TextField(
                    controller: direccionController,
                    decoration: const InputDecoration(labelText: "Dirección"),
                  ),

                  TextField(
                    controller: pedidoController,
                    decoration: const InputDecoration(labelText: "Pedido"),
                  ),

                  TextField(
                    controller: comentariosController,
                    decoration: const InputDecoration(labelText: "Observaciones"),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: enviarWhatsApp,
                    child: const Text("Enviar Pedido"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text("© 2025 Dulce Antojo"),

            const SizedBox(height: 30)

          ],
        ),
      ),
    );
  }

  Widget productCard(String nombre, double precio, String imagen) {
    return Card(
      child: Column(
        children: [
          Image.asset(imagen, height: 100),
          Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("L $precio"),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Agregar al carrito"),
          )
        ],
      ),
    );
  }
}