class AddToCart {
  static Map<String, dynamic> add({
    required List<Map<String, dynamic>> cart,
    required int id,
    required String nombre,
    required double precio,
    int cantidad = 1,
    String imagen = 'assets/images/default.jpg',
  }) {
    final index = cart.indexWhere((item) => item["id"] == id);

    if (index != -1) {
      cart[index]["cantidad"] += cantidad;
    } else {
      cart.add({
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "cantidad": cantidad,
        "imagen": imagen,
      });
    }

    int totalItems = 0;
    for (var item in cart) {
      totalItems += item["cantidad"] as int;
    }

    return {
      "success": true,
      "totalItems": totalItems,
      "message": "¡Producto agregado al carrito!",
    };
  }
}