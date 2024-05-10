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
}

List<FoodItem> foodItems = [
  FoodItem(
    id: 1,
    title: 'Nasi Goreng',
    description: 'Nasi goreng istimewa dengan bumbu tradisional.',
    price: 20000,
    imgName: 'food1.jpg',
  ),
  FoodItem(
    id: 2,
    title: 'Mie Goreng',
    description: 'Mie goreng spesial dengan campuran bumbu rahasia.',
    price: 15000,
    imgName: 'food2.jpg',
  ),
  FoodItem(
    id: 3,
    title: 'Ayam Bakar',
    description: 'Ayam bakar dengan cita rasa khas Indonesia.',
    price: 25000,
    imgName: 'food3.jpg',
  ),
  FoodItem(
    id: 4,
    title: 'Soto Ayam',
    description: 'Soto ayam dengan kuah gurih dan daging ayam lembut.',
    price: 18000,
    imgName: 'food4.jpg',
  ),
];
