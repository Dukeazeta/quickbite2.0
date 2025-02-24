// Data model representing a dish in the application
class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> categories;
  final bool isAvailable;

  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.categories = const [],
    this.isAvailable = true,
  });

  // Convert Dish to Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categories': categories,
      'isAvailable': isAvailable,
    };
  }

  // Create Dish from Map for deserialization
  factory Dish.fromMap(Map<String, dynamic> map) {
    return Dish(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      categories: List<String>.from(map['categories'] as List),
      isAvailable: map['isAvailable'] as bool,
    );
  }
}