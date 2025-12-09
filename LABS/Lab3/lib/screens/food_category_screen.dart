import 'package:flutter/material.dart';
import 'package:lab3_recipe_app/screens/profile.dart';

import '../models/food_model.dart';
import '../models/food_details_model.dart';
import '../services/api_service.dart';
import '../widgets/food_grid_item.dart';
import 'favorite_screen.dart';
import 'food_details_screen.dart';
import '../services/favorite_service.dart';

const Color screenBg = Color(0xFF803636);

class FoodsByCategoryScreen extends StatefulWidget {
  final String categoryName;

  const FoodsByCategoryScreen({
    super.key,
    required this.categoryName,
  });

  @override
  State<FoodsByCategoryScreen> createState() => _FoodsByCategoryScreenState();
}

class _FoodsByCategoryScreenState extends State<FoodsByCategoryScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  late List<Food> _foods;
  List<Food> _filteredFoods = [];

  bool _isLoading = true;
  bool _isSearchingApi = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    try {
      final foods = await _apiService.getFoodByCategory(widget.categoryName);
      setState(() {
        _foods = foods;
        _filteredFoods = foods;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to load foods',
            style: TextStyle(fontSize: 11),
          ),
        ),
      );
    }
  }

  void _filterFoodsLocally(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredFoods = _foods;
      } else {
        _filteredFoods = _foods
            .where((food) =>
            food.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _searchFoodsInApi() async {
    if (_searchQuery.trim().isEmpty) return;

    setState(() {
      _isSearchingApi = true;
    });

    try {
      final results = await _apiService.searchFood(_searchQuery);

      final filtered = results
          .where((food) =>
      food.category == null || food.category == widget.categoryName)
          .toList();

      setState(() {
        _filteredFoods = filtered;
        _isSearchingApi = false;
      });

      if (filtered.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No foods found in API',
              style: TextStyle(fontSize: 11),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSearchingApi = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'API search failed',
            style: TextStyle(fontSize: 11),
          ),
        ),
      );
    }
  }

  Future<void> _openFoodDetails(Food food) async {
    try {
      final FoodDetails? details = await _apiService.getFoodDetails(food.id);

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
              'No food details found',
              style: TextStyle(fontSize: 11),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to load details',
            style: TextStyle(fontSize: 11),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFFEF8F5),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
            icon: const Icon(
              Icons.favorite,
              color: Color(0xFF4A3A32),
              size: 14,
            ),
            label: const Text(
              'View Favorites',
              style: TextStyle(
                color: Color(0xFF4A3A32),
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '|',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
            icon: const Icon(
              Icons.person,
              color: Color(0xFF4A3A32),
              size: 18,
            ),
          ),
        ],
      ),

      // ✅ FIXED: SafeArea + no overflow + proper scrolling
      body: SafeArea(
        child: Container(
          color: screenBg,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 11),
                  decoration: InputDecoration(
                    hintText: 'Search foods...',
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 16,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: _filterFoodsLocally,
                ),
              ),

              // GRID VIEW
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7, // prevent overflow
                    ),
                    itemCount: _filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = _filteredFoods[index];
                      final isFavorite =
                      FavoriteService.isFavorite(food);

                      return FoodGridItem(
                        food: food,
                        onTap: () => _openFoodDetails(food),
                        isFavorite: isFavorite,
                        onTapFavorite: () {
                          setState(() {
                            FavoriteService.toggleFavorite(food);
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
