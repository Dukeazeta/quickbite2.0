import 'package:flutter/material.dart';
import 'package:quickbite2_0/features/dishes/presentation/widgets/food_category_icon.dart';
import 'package:quickbite2_0/features/dishes/presentation/widgets/promo_banner.dart';
import 'package:quickbite2_0/features/dishes/presentation/widgets/restaurant_card.dart';

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
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildSearchBar(),
                  _buildCategories(),
                  _buildPromoBanner(),
                  _buildFastestNearYou(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.orange),
          SizedBox(width: 8),
          Text(
            '1226 University Dr',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.keyboard_arrow_down),
          Spacer(),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search "Ice Cream"',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.tune),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          FoodCategoryIcon(
            iconPath: 'assets/images/deals.png',
            label: 'Deals',
            onTap: () {},
          ),
          SizedBox(width: 16),
          FoodCategoryIcon(
            iconPath: 'assets/images/dashmart.png',
            label: 'DashMart',
            onTap: () {},
          ),
          SizedBox(width: 16),
          FoodCategoryIcon(
            iconPath: 'assets/images/convenience.png',
            label: 'Convenience',
            onTap: () {},
          ),
          // Add more categories as needed
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return PromoBanner(
      title: '40% off 1st order, up to \$10',
      subtitle: '+\$0 delivery fee on orders \$15+ with code GET40OFF1',
      imageUrl: 'https://example.com/promo-image.jpg',
      onTap: () {},
    );
  }

  Widget _buildFastestNearYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Fastest near you',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              RestaurantCard(
                name: 'Starbucks',
                imageUrl: 'https://example.com/starbucks.jpg',
                deliveryTime: '10-15 min',
                rating: 4.5,
                onTap: () {},
              ),
              RestaurantCard(
                name: 'McDonald\'s',
                imageUrl: 'https://example.com/mcdonalds.jpg',
                deliveryTime: '15-25 min',
                rating: 4.2,
                onTap: () {},
              ),
              // Add more restaurants as needed
            ],
          ),
        ),
      ],
    );
  }
}
