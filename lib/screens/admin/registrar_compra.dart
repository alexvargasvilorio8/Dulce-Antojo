import 'package:flutter/material.dart';

class RegistrarCompra extends StatefulWidget {
  const RegistrarCompra({super.key});

  @override
  State<RegistrarCompra> createState() => _RegistrarCompraState();
}

class _RegistrarCompraState extends State<RegistrarCompra> {
  final TextEditingController lugarController = TextEditingController();
  final TextEditingController fechaController = TextEditingController(
    text: DateTime.now().toString().split(' ')[0],
  );
  final TextEditingController totalController = TextEditingController();
  final TextEditingController montoExentoController =
      TextEditingController(text: "0.00");

  String mesSeleccionado = DateTime.now().toString().substring(0, 7);

  List<Map<String, dynamic>> comprasMes = [
    {
      "fecha": "2026-03-05",
      "lugar": "Supermercado La Colonia",
      "total": 500.00,
      "monto_exento": 50.00,
      "monto_sin_impuesto": 391.30,
      "impuesto": 58.70,
    },
    {
      "fecha": "2026-03-11",
      "lugar": "Distribuidora Centro",
      "total": 920.00,
      "monto_exento": 120.00,
      "monto_sin_impuesto": 695.65,
      "impuesto": 104.35,
    },
  ];

  double get totalGastado => double.tryParse(totalController.text) ?? 0.0;

  double get montoExento => double.tryParse(montoExentoController.text) ?? 0.0;

  double get montoSinImpuesto {
    final base = totalGastado - montoExento;
    if (base <= 0) return 0.0;
    return base / 1.15;
  }

  double get impuesto {
    final base = totalGastado - montoExento;
    if (base <= 0) return 0.0;
    return base - montoSinImpuesto;
  }

  void recalcular() {
    setState(() {});
  }

  void guardarCompra() {
    final lugar = lugarController.text.trim();
    final fecha = fechaController.text.trim();

    if (lugar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa el lugar de la compra"),
        ),
      );
      return;
    }

    if (fecha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa la fecha"),
        ),
      );
      return;
    }

    if (totalGastado <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa un total válido"),
        ),
      );
      return;
    }

    final nuevaCompra = {
      "fecha": fecha,
      "lugar": lugar,
      "total": totalGastado,
      "monto_exento": montoExento,
      "monto_sin_impuesto": montoSinImpuesto,
      "impuesto": impuesto,
    };

    setState(() {
      comprasMes.insert(0, nuevaCompra);
      lugarController.clear();
      fechaController.text = DateTime.now().toString().split(' ')[0];
      totalController.clear();
      montoExentoController.text = "0.00";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Compra registrada correctamente"),
      ),
    );
  }

  @override
  void dispose() {
    lugarController.dispose();
    fechaController.dispose();
    totalController.dispose();
    montoExentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sumSinImpuesto = comprasMes.fold<double>(
      0,
      (sum, c) => sum + (c["monto_sin_impuesto"] as double),
    );

    final sumImpuesto = comprasMes.fold<double>(
      0,
      (sum, c) => sum + (c["impuesto"] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Compra"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Registrar Compra",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: lugarController,
              decoration: const InputDecoration(
                labelText: "Lugar de la compra",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: "Fecha",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: totalController,
              keyboardType: TextInputType.number,
              onChanged: (_) => recalcular(),
              decoration: const InputDecoration(
                labelText: "Total gastado",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: montoExentoController,
              keyboardType: TextInputType.number,
              onChanged: (_) => recalcular(),
              decoration: const InputDecoration(
                labelText: "Monto exento",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Resumen calculado",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    filaResumen("Monto sin impuesto", montoSinImpuesto),
                    const SizedBox(height: 8),
                    filaResumen("Impuesto", impuesto),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: guardarCompra,
                    child: const Text("Guardar Compra"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("← Volver"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            const Text(
              "Compras del mes",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: TextEditingController(text: mesSeleccionado),
              decoration: const InputDecoration(
                labelText: "Filtrar por mes",
                hintText: "Ejemplo: 2026-03",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                mesSeleccionado = value;
              },
            ),

            const SizedBox(height: 16),

            comprasMes.isEmpty
                ? Text("No hay compras para $mesSeleccionado.")
                : Column(
                    children: [
                      ...comprasMes.map((compra) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text(compra["lugar"]),
                            subtitle: Text(compra["fecha"]),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "L ${compra["total"].toStringAsFixed(2)}",
                                ),
                                Text(
                                  "Imp: ${compra["impuesto"].toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      Card(
                        color: Colors.pink.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              filaResumen("Totales - Monto sin impuesto", sumSinImpuesto),
                              const SizedBox(height: 8),
                              filaResumen("Totales - Impuesto", sumImpuesto),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget filaResumen(String texto, double valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(texto),
        Text(
          "L ${valor.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}