import 'package:flutter/material.dart';
import '../services/add_to_cart.dart';
import 'carrito.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  List<Map<String, dynamic>> cart = [];

  final List<Map<String, dynamic>> productos = [
    {
      "id": 1,
      "nombre": "Cheesecake Fresa",
      "precio": 180.0,
      "img": "assets/images/cheesecake.jpg"
    },
    {
      "id": 2,
      "nombre": "Brownies",
      "precio": 100.0,
      "img": "assets/images/brownies.jpg"
    },
    {
      "id": 3,
      "nombre": "Flan",
      "precio": 90.0,
      "img": "assets/images/flan.jpg"
    },
    {
      "id": 4,
      "nombre": "Pastel Tres Leches",
      "precio": 250.0,
      "img": "assets/images/tresleches.jpg"
    }
  ];

  void agregarAlCarrito(Map<String, dynamic> producto) {

    final result = AddToCart.add(
      cart: cart,
      id: producto["id"],
      nombre: producto["nombre"],
      precio: producto["precio"],
      cantidad: 1,
      imagen: producto["img"],
    );

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result["message"]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú de Postres"),
        actions: [

          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(cart: cart),
                ),
              );
            },
          )

        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: productos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {

            final producto = productos[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                children: [

                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        producto["img"],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [

                        Text(
                          producto["nombre"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "L ${producto["precio"].toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              agregarAlCarrito(producto);
                            },
                            child: const Text("Agregar al carrito"),
                          ),
                        )

                      ],
                    ),
                  )

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}