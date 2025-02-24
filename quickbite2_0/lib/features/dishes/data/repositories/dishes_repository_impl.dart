import 'package:quickbite2_0/features/dishes/domain/models/dish.dart';
import 'package:quickbite2_0/features/dishes/domain/repositories/dishes_repository.dart';

class DishesRepositoryImpl implements DishesRepository {
  // Mock data for dishes
  final List<Dish> _mockDishes = [
    Dish(
      id: '1',
      name: 'Margherita Pizza',
      description: 'Classic Italian pizza with tomatoes and mozzarella',
      price: 12.99,
      imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3',
      categories: ['Pizza', 'Italian'],
    ),
    Dish(
      id: '2',
      name: 'Chicken Burger',
      description: 'Juicy chicken patty with fresh vegetables',
      price: 8.99,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      categories: ['Burger', 'Fast Food'],
    ),
    Dish(
      id: '3',
      name: 'Caesar Salad',
      description: 'Fresh romaine lettuce with Caesar dressing',
      price: 7.99,
      imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1',
      categories: ['Salad', 'Healthy'],
    ),
    Dish(
      id: '4',
      name: 'Pasta Carbonara',
      description: 'Creamy pasta with bacon and parmesan',
      price: 11.99,
      imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3',
      categories: ['Pasta', 'Italian'],
    ),
  ];

  @override
  Future<List<Dish>> getAllDishes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockDishes;
  }

  @override
  Future<List<Dish>> getDishesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockDishes
        .where((dish) => dish.categories.contains(category))
        .toList();
  }

  @override
  Future<Dish?> getDishById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDishes.firstWhere(
      (dish) => dish.id == id,
      orElse: () => throw Exception('Dish not found'),
    );
  }
}