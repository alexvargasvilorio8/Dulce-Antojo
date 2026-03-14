import 'package:flutter/material.dart';
import 'registrar_venta.dart';
import 'registrar_compra.dart';
import 'calcular_impuestos.dart';

class AdminIndex extends StatelessWidget {
  final String nombre;

  const AdminIndex({
    super.key,
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 260,
            color: Colors.pink.shade100,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dulce Antojo",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                _menuButton(
                  context,
                  icon: Icons.add_shopping_cart,
                  texto: "Registrar Venta",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrarVenta(),
                      ),
                    );
                  },
                ),
                _menuButton(
                  context,
                  icon: Icons.inventory_2,
                  texto: "Registrar Compra",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrarCompra(),
                      ),
                    );
                  },
                ),
                _menuButton(
                  context,
                  icon: Icons.calculate,
                  texto: "Calcular Impuestos",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalcularImpuestos(),
                      ),
                    );
                  },
                ),
                _menuButton(
                  context,
                  icon: Icons.logout,
                  texto: "Cerrar sesión",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenida, $nombre",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Selecciona una opción del menú para empezar a administrar las ventas y compras.",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(
    BuildContext context, {
    required IconData icon,
    required String texto,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        leading: Icon(icon),
        title: Text(texto),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.white,
        onTap: onTap,
      ),
    );
  }
}