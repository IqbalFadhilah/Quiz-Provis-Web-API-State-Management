class CartItem {
  final int id; // ID item dalam keranjang
  final int itemId; // ID item yang dipesan
  final int userId; // ID pengguna yang memesan
  int quantity; // Jumlah item yang dipesan

  CartItem({
    required this.id,
    required this.itemId,
    required this.userId,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      itemId: json['item_id'],
      userId: json['user_id'],
      quantity: json['quantity'],
    );
  }
}