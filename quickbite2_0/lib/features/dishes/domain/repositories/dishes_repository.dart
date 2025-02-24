import 'package:quickbite2_0/features/dishes/domain/models/dish.dart';

// Abstract class defining the contract for dish-related operations
abstract class DishesRepository {
  // Get all available dishes
  Future<List<Dish>> getAllDishes();

  // Get dishes by category
  Future<List<Dish>> getDishesByCategory(String category);

  // Get a specific dish by ID
  Future<Dish?> getDishById(String id);
}