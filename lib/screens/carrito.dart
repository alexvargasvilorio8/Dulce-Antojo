import 'package:flutter/material.dart';
import '../services/update_cart.dart';
import '../services/remove_from_cart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  List<Map<String, dynamic>> cart = [
    {
      "id": 1,
      "nombre": "Cheesecake Fresa",
      "precio": 180.0,
      "cantidad": 1,
      "imagen": "assets/images/cheesecake.jpg"
    },
    {
      "id": 2,
      "nombre": "Brownies",
      "precio": 100.0,
      "cantidad": 2,
      "imagen": "assets/images/brownies.jpg"
    }
  ];

  double get total {
    double sum = 0;
    for (var item in cart) {
      sum += item["precio"] * item["cantidad"];
    }
    return sum;
  }

  void increaseQty(int index) {
    setState(() {
      cart[index]["cantidad"]++;
    });
  }

  void decreaseQty(int index) {
    setState(() {
      if (cart[index]["cantidad"] > 1) {
        cart[index]["cantidad"]--;
      }
    });
  }

  void removeItem(int index) {
  setState(() {
    RemoveFromCart.remove(
      cart: cart,
      id: cart[index]["id"],
    );
  });
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Carrito"),
      ),

      body: cart.isEmpty
          ? const Center(
              child: Text(
                "Tu carrito está vacío",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [

                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {

                      final item = cart[index];

                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [

                              Image.asset(
                                item["imagen"],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      item["nombre"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),

                                    Text(
                                      "L ${item["precio"]}",
                                      style: const TextStyle(
                                          color: Colors.pink),
                                    ),

                                    Text(
                                      "Subtotal: L ${(item["precio"] * item["cantidad"]).toStringAsFixed(2)}",
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                children: [

                                  Row(
                                    children: [

                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          decreaseQty(index);
                                        },
                                      ),

                                      Text(
                                        item["cantidad"].toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),

                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          increaseQty(index);
                                        },
                                      ),
                                    ],
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      removeItem(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ],
                  ),

                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal"),
                          Text("L ${total.toStringAsFixed(2)}")
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "L ${total.toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                                cart.clear();
                              });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pedido realizado"),
                              ),
                            );
                          },
                          child: const Text("Realizar Pedido"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
