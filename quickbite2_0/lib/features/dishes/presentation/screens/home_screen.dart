import 'package:flutter/material.dart';
import 'package:quickbite2_0/features/dishes/data/repositories/dishes_repository_impl.dart';
import 'package:quickbite2_0/features/dishes/domain/models/dish.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = DishesRepositoryImpl();

    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<List<Dish>>(
        future: repository.getAllDishes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          }

          final dishes = snapshot.data ?? [];
          return _buildDishesGrid(dishes);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('QuickBite'),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _buildDishesGrid(List<Dish> dishes) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: dishes.length,
      itemBuilder: (context, index) => _buildDishCard(context, dishes[index]),
    );
  }

  Widget _buildDishCard(BuildContext context, Dish dish) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDishImage(dish.imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDishName(context, dish.name),
                const SizedBox(height: 4),
                _buildPriceAndAddButton(context, dish.price),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishImage(String imageUrl) {
    return Expanded(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDishName(BuildContext context, String name) {
    return Flexible(
      child: Text(
        name,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 14,
            ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPriceAndAddButton(BuildContext context, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              // TODO: Implement add to cart functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart')),
              );
            },
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
