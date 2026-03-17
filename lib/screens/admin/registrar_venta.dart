import 'package:flutter/material.dart';
import 'detalle_factura.dart';

class RegistrarVenta extends StatefulWidget {
  const RegistrarVenta({super.key});

  @override
  State<RegistrarVenta> createState() => _RegistrarVentaState();
}

class _RegistrarVentaState extends State<RegistrarVenta> {
  final TextEditingController vendidoAController = TextEditingController();
  final TextEditingController fechaController = TextEditingController(
    text: DateTime.now().toString().split(' ')[0],
  );

  String mesSeleccionado = DateTime.now().toString().substring(0, 7);

  final List<Map<String, dynamic>> productosDisponibles = [
    {"id": 1, "nombre": "Cheesecake Fresa"},
    {"id": 2, "nombre": "Brownies"},
    {"id": 3, "nombre": "Flan"},
    {"id": 4, "nombre": "Pastel Tres Leches"},
  ];

  List<Map<String, dynamic>> productosFactura = [
    {
      "producto_id": null,
      "producto_nombre": "",
      "precio_venta": 0.0,
      "cantidad": 1,
    }
  ];

  List<Map<String, dynamic>> facturasMes = [
    {
      "id": 1,
      "fecha": "2026-03-05",
      "vendido_a": "María López",
      "subtotal": 260.87,
      "iva": 39.13,
      "total": 300.00,
    },
    {
      "id": 2,
      "fecha": "2026-03-10",
      "vendido_a": "Carlos Pérez",
      "subtotal": 173.91,
      "iva": 26.09,
      "total": 200.00,
    },
  ];

  double get subtotalGeneral {
    double subtotal = 0;
    for (var item in productosFactura) {
      final precioVenta = (item["precio_venta"] as double);
      final cantidad = (item["cantidad"] as int);
      subtotal += (precioVenta / 1.15) * cantidad;
    }
    return subtotal;
  }

  double get ivaTotal => subtotalGeneral * 0.15;

  double get totalGeneral => subtotalGeneral + ivaTotal;

  double subtotalProducto(Map<String, dynamic> item) {
    final precioVenta = (item["precio_venta"] as double);
    final cantidad = (item["cantidad"] as int);
    return (precioVenta / 1.15) * cantidad;
  }

  void agregarProducto() {
    setState(() {
      productosFactura.add({
        "producto_id": null,
        "producto_nombre": "",
        "precio_venta": 0.0,
        "cantidad": 1,
      });
    });
  }

  void eliminarProducto(int index) {
    setState(() {
      if (productosFactura.length == 1) {
        productosFactura[0] = {
          "producto_id": null,
          "producto_nombre": "",
          "precio_venta": 0.0,
          "cantidad": 1,
        };
      } else {
        productosFactura.removeAt(index);
      }
    });
  }

  void guardarFactura() {
    final vendidosA = vendidoAController.text.trim();

    final productosValidos = productosFactura
        .where((p) => p["producto_id"] != null)
        .toList();

    if (productosValidos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Agrega al menos un producto a la factura"),
        ),
      );
      return;
    }

    if (vendidosA.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingresa a quién se le vendió"),
        ),
      );
      return;
    }

    final nuevaFactura = {
      "id": facturasMes.length + 1,
      "fecha": fechaController.text,
      "vendido_a": vendidosA,
      "subtotal": subtotalGeneral,
      "iva": ivaTotal,
      "total": totalGeneral,
    };

    setState(() {
      facturasMes.insert(0, nuevaFactura);
      productosFactura = [
        {
          "producto_id": null,
          "producto_nombre": "",
          "precio_venta": 0.0,
          "cantidad": 1,
        }
      ];
      vendidoAController.clear();
      fechaController.text = DateTime.now().toString().split(' ')[0];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Factura registrada correctamente (ID: ${nuevaFactura["id"]})"),
      ),
    );
  }

  @override
  void dispose() {
    vendidoAController.dispose();
    fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sumSubtotal = facturasMes.fold<double>(
      0,
      (sum, f) => sum + (f["subtotal"] as double),
    );
    final sumIva = facturasMes.fold<double>(
      0,
      (sum, f) => sum + (f["iva"] as double),
    );
    final sumTotal = facturasMes.fold<double>(
      0,
      (sum, f) => sum + (f["total"] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Venta"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Registrar Venta / Nueva Factura",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            ...List.generate(productosFactura.length, (index) {
              final item = productosFactura[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      DropdownButtonFormField<int>(
                        value: item["producto_id"],
                        decoration: const InputDecoration(
                          labelText: "Producto",
                          border: OutlineInputBorder(),
                        ),
                        items: productosDisponibles.map((producto) {
                          return DropdownMenuItem<int>(
                            value: producto["id"] as int,
                            child: Text(producto["nombre"] as String),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            item["producto_id"] = value;
                            final producto = productosDisponibles.firstWhere(
                              (p) => p["id"] == value,
                              orElse: () => {"nombre": ""},
                            );
                            item["producto_nombre"] = producto["nombre"];
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: item["precio_venta"] == 0.0
                            ? ""
                            : item["precio_venta"].toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Precio venta (L, incluye IVA)",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            item["precio_venta"] = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: item["cantidad"].toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Cantidad",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            item["cantidad"] = int.tryParse(value) ?? 1;
                            if (item["cantidad"] < 1) {
                              item["cantidad"] = 1;
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Subtotal (s/ IVA): L ${subtotalProducto(item).toStringAsFixed(2)}",
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () => eliminarProducto(index),
                          icon: const Icon(Icons.delete),
                          label: const Text("Eliminar"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            ElevatedButton(
              onPressed: agregarProducto,
              child: const Text("+ Agregar otro producto"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: vendidoAController,
              decoration: const InputDecoration(
                labelText: "Vendido a",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: "Fecha de venta",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Totales",
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
                    filaTotal("Subtotal general (s/ IVA)", subtotalGeneral),
                    const SizedBox(height: 8),
                    filaTotal("IVA 15%", ivaTotal),
                    const SizedBox(height: 8),
                    filaTotal("Total a pagar", totalGeneral),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: guardarFactura,
                    child: const Text("Guardar Factura"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Volver"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),

            const Text(
              "Facturas del mes",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              decoration: const InputDecoration(
                labelText: "Filtrar por mes",
                hintText: "Ejemplo: 2026-03",
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: mesSeleccionado),
              onChanged: (value) {
                mesSeleccionado = value;
              },
            ),

            const SizedBox(height: 16),

            facturasMes.isEmpty
                ? Text("No hay facturas para $mesSeleccionado.")
                : Column(
                    children: [
                      ...facturasMes.map((factura) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            title: Text("Factura #${factura["id"]}"),
                            subtitle: Text(
                              "${factura["fecha"]} - ${factura["vendido_a"]}",
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("L ${factura["total"].toStringAsFixed(2)}"),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetalleFactura(
                                          facturaId: factura["id"],
                                          vendidoA: factura["vendido_a"],
                                          fecha: factura["fecha"],
                                          subtotal: factura["subtotal"],
                                          iva: factura["iva"],
                                          total: factura["total"],
                                          productos: [
                                            {
                                              "nombre": "Cheesecake Fresa",
                                              "cantidad": 2,
                                              "precio": 156.52,
                                              "subtotal": 313.04,
                                            }
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Ver"),
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
                              filaTotal("Totales del mes - Subtotal", sumSubtotal),
                              const SizedBox(height: 8),
                              filaTotal("Totales del mes - IVA", sumIva),
                              const SizedBox(height: 8),
                              filaTotal("Totales del mes - Total", sumTotal),
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

  Widget filaTotal(String texto, double valor) {
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