class UpdateCart {
  static void updateCart({
    required List<Map<String, dynamic>> cart,
    required int id,
    required String action,
  }) {
    final index = cart.indexWhere((item) => item["id"] == id);

    if (index == -1) return;

    if (action == "increase") {
      cart[index]["cantidad"]++;
    } else if (action == "decrease") {
      cart[index]["cantidad"]--;

      if (cart[index]["cantidad"] <= 0) {
        cart.removeAt(index);
      }
    }
  }
}