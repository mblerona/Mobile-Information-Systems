import 'package:flutter/material.dart';
import '../services/favorite_service.dart';
import '../widgets/food_grid_item.dart';
import '../models/food_model.dart';
import '../models/food_details_model.dart';
import '../services/api_service.dart';
import 'food_details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ApiService _api = ApiService();

  Future<void> _openFoodDetails(Food food) async {
    final details = await _api.getFoodDetails(food.id);

    if (!mounted) return;

    if (details != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const FoodDetailsScreen(),
          settings: RouteSettings(arguments: details),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to load details",
            style: TextStyle(fontSize: 11),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteService.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorite Recipes",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFFEF8F5),
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorites yet!",
          style: TextStyle(fontSize: 11, color: Colors.grey),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemCount: favorites.length,
        itemBuilder: (_, index) {
          final food = favorites[index];
          return FoodGridItem(
            food: food,
            onTap: () => _openFoodDetails(food),
            isFavorite: true,
            onTapFavorite: () {
              setState(() {
                FavoriteService.toggleFavorite(food);
              });
            },
          );
        },
      ),
    );
  }
}
