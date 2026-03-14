import 'package:flutter/material.dart';

class MiCuenta extends StatefulWidget {
  const MiCuenta({super.key});

  @override
  State<MiCuenta> createState() => _MiCuentaState();
}

class _MiCuentaState extends State<MiCuenta> {

  Map<String, String> usuario = {
    "nombre": "Juan Pérez",
    "email": "juan@email.com",
    "direccion": "Colonia Bella Vista",
    "telefono": "9999-9999"
  };

  List<Map<String, dynamic>> pedidos = [
    {
      "id": 1,
      "fecha": "15/03/2026",
      "estado": "Pendiente",
      "total": 280.00
    },
    {
      "id": 2,
      "fecha": "10/03/2026",
      "estado": "Completado",
      "total": 150.00
    }
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Cuenta"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Bienvenida
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hola ${usuario["nombre"]}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const Text("Bienvenido a Dulce Antojo")
                      ],
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Cerrar sesión"),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Datos del usuario
            const Text(
              "Mis Datos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Nombre: ${usuario["nombre"]}"),
                    const SizedBox(height: 10),

                    Text("Correo: ${usuario["email"]}"),
                    const SizedBox(height: 10),

                    Text("Dirección: ${usuario["direccion"]}"),
                    const SizedBox(height: 10),

                    Text("Teléfono: ${usuario["telefono"]}"),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Editar Datos"),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// Acciones rápidas
            const Text(
              "Acciones Rápidas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 10),

            Column(
              children: [

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Ver mi carrito"),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Explorar productos"),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Cambiar contraseña"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Historial de pedidos
            const Text(
              "Mis Pedidos",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 10),

            pedidos.isEmpty
                ? const Center(
                    child: Text("No tienes pedidos todavía"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: pedidos.length,

                    itemBuilder: (context, index) {

                      final pedido = pedidos[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),

                        child: ListTile(
                          title: Text("Pedido #${pedido["id"]}"),
                          subtitle: Text("Fecha: ${pedido["fecha"]}"),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("L ${pedido["total"]}"),
                              Text(pedido["estado"])
                            ],
                          ),

                          onTap: () {
                            /// aquí abriría detalle_pedido.dart
                          },
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}