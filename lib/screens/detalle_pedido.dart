import 'package:flutter/material.dart';

class DetallePedido extends StatelessWidget {

  final Map pedido;
  final List items;

  const DetallePedido({
    super.key,
    required this.pedido,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Pedido #${pedido['id']}"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Pedido #${pedido['id']}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Fecha: ${pedido['creado_en']}"),
                  Text("Estado: ${pedido['estado']}"),
                  Text("Total: L ${pedido['total']}"),

                  if (pedido['direccion_entrega'] != null)
                    Text("Dirección: ${pedido['direccion_entrega']}"),

                  if (pedido['telefono'] != null)
                    Text("Teléfono: ${pedido['telefono']}"),

                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Productos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(

                itemCount: items.length,

                itemBuilder: (context, index) {

                  final item = items[index];

                  final subtotal =
                      item["precio_unit"] * item["cantidad"];

                  return Card(

                    child: ListTile(

                      title: Text(item["nombre"]),

                      subtitle: Text(
                        "Cantidad: ${item["cantidad"]}",
                      ),

                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text("L ${item["precio_unit"]}"),

                          Text(
                            "Subtotal: L $subtotal",
                            style: const TextStyle(fontSize: 12),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Volver a mis pedidos"),
              ),
            )

          ],
        ),
      ),
    );
  }
}