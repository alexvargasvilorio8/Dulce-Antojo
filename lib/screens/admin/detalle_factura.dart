import 'package:flutter/material.dart';

class DetalleFactura extends StatelessWidget {
  final int facturaId;
  final String vendidoA;
  final String fecha;
  final double subtotal;
  final double iva;
  final double total;
  final List<Map<String, dynamic>> productos;

  const DetalleFactura({
    super.key,
    required this.facturaId,
    required this.vendidoA,
    required this.fecha,
    required this.subtotal,
    required this.iva,
    required this.total,
    required this.productos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Factura #$facturaId"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// información de factura
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detalle de factura #$facturaId",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Vendido a: $vendidoA"),
                    Text("Fecha: $fecha"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// tabla productos
            Expanded(
              child: productos.isEmpty
                  ? const Center(
                      child: Text("No hay productos en esta factura"),
                    )
                  : ListView(
                      children: [
                        DataTable(
                          columns: const [
                            DataColumn(label: Text("Producto")),
                            DataColumn(label: Text("Cantidad")),
                            DataColumn(label: Text("Precio s/IVA")),
                            DataColumn(label: Text("Subtotal")),
                          ],
                          rows: productos.map((producto) {
                            return DataRow(
                              cells: [
                                DataCell(Text(producto["nombre"])),
                                DataCell(Text(producto["cantidad"].toString())),
                                DataCell(
                                  Text(
                                      "L ${producto["precio"].toStringAsFixed(2)}"),
                                ),
                                DataCell(
                                  Text(
                                      "L ${producto["subtotal"].toStringAsFixed(2)}"),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 10),

            /// totales
            Card(
              color: Colors.pink.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    filaTotal("Subtotal general", subtotal),
                    const SizedBox(height: 5),
                    filaTotal("IVA 15%", iva),
                    const SizedBox(height: 5),
                    filaTotal("Total", total),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            /// botón volver
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Volver"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filaTotal(String titulo, double valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo),
        Text(
          "L ${valor.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}