class FoodItem {
  final int id;
  final String title;
  final String description;
  final int price;
  final String imgName;

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imgName,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imgName: json['img_name'],
    );
  }
}