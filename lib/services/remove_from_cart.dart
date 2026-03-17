class RemoveFromCart {

  static void remove({
    required List<Map<String, dynamic>> cart,
    required int id,
  }) {

    cart.removeWhere((item) => item["id"] == id);

  }

}