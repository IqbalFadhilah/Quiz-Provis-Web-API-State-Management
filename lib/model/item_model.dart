// Item class
class Item {
  final int id;
  final String title;
  final String description;
  final double price;
  final String img_name;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.img_name,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      img_name: json['img_name'],
    );
  }
}