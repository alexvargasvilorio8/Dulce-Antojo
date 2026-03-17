import 'package:flutter/material.dart';

class CalcularImpuestos extends StatefulWidget {
  const CalcularImpuestos({super.key});

  @override
  State<CalcularImpuestos> createState() => _CalcularImpuestosState();
}

class _CalcularImpuestosState extends State<CalcularImpuestos> {
  final TextEditingController mesController = TextEditingController(
    text: DateTime.now().toString().substring(0, 7),
  );

  final TextEditingController excedenteController = TextEditingController(
    text: "0.00",
  );

  double totalVentasSubtotal = 2500.00;
  double totalVentasIva = 375.00;
  double totalComprasSinImpuesto = 1200.00;
  double totalComprasImpuesto = 180.00;
  double totalComprasExento = 150.00;

  double? montoTotalPagar;

  void calcularMonto() {
    final excedente = double.tryParse(excedenteController.text) ?? 0.0;

    final resultado =
        (totalVentasIva - totalComprasImpuesto) + excedente;

    setState(() {
      montoTotalPagar = resultado < 0 ? 0 : resultado;
    });
  }

  @override
  void dispose() {
    mesController.dispose();
    excedenteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calcular Impuestos"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Resumen del mes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: mesController,
              decoration: const InputDecoration(
                labelText: "Selecciona mes",
                hintText: "Ejemplo: 2026-03",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    filaResumen("Total ventas (sub-total)", totalVentasSubtotal),
                    const SizedBox(height: 8),
                    filaResumen("Total ventas (15% IVA)", totalVentasIva),
                    const SizedBox(height: 8),
                    filaResumen(
                      "Total compras (monto sin impuesto)",
                      totalComprasSinImpuesto,
                    ),
                    const SizedBox(height: 8),
                    filaResumen(
                      "Total compras (impuesto)",
                      totalComprasImpuesto,
                    ),
                    const SizedBox(height: 8),
                    filaResumen(
                      "Total compras (monto exento)",
                      totalComprasExento,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: excedenteController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Excedente del periodo anterior",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: calcularMonto,
                    child: const Text("Calcular monto total a pagar"),
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

            const SizedBox(height: 20),

            if (montoTotalPagar != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  "Monto total a pagar: L ${montoTotalPagar!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
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
        Expanded(child: Text(texto)),
        Text(
          "L ${valor.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}