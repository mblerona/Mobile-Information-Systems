import 'package:flutter/material.dart';
import 'package:lab3_recipe_app/screens/profile.dart';

import '../models/category_model.dart';
import '../models/food_details_model.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'favorite_screen.dart';
import 'food_details_screen.dart';
import 'food_category_screen.dart';

const Color screenBg = Color(0xFF803636);

class CategoriesScreen extends StatefulWidget {
  final String title;

  const CategoriesScreen({super.key, required this.title});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  late List<Category> _categories;
  List<Category> _filteredCategories = [];

  bool _isLoading = true;
  bool _isRandomLoading = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _apiService.getCategories();
      setState(() {
        _categories = categories;
        _filteredCategories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to load',
            style: TextStyle(fontSize: 11),
          ),
        ),
      );
    }
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where(
              (category) =>
              category.name.toLowerCase().contains(query.toLowerCase()),
        )
            .toList();
      }
    });
  }

  Future<void> _openRandomFood() async {
    setState(() {
      _isRandomLoading = true;
    });

    try {
      final FoodDetails? randomFood = await _apiService.getRandomFood();

      if (!mounted) return;

      setState(() {
        _isRandomLoading = false;
      });

      if (randomFood != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const FoodDetailsScreen(),
            settings: RouteSettings(arguments: randomFood),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No random recipe found',
              style: TextStyle(fontSize: 11),
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isRandomLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to load random recipe',
            style: TextStyle(fontSize: 11),
          ),
        ),
      );
    }
  }

  void _openCategory(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FoodsByCategoryScreen(
          categoryName: category.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFFEF8F5),
        actions: [
          // View Favorites button
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

          // Separator |
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

          // Profile icon
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              print("Profile tapped");
            },
            icon: const Icon(
              Icons.person,
              color: Color(0xFF4A3A32),
              size: 18,
            ),
          ),
        ],
      ),
      body: Container(
        color: screenBg,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SizedBox(
                height: 38,

                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 11),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    hintText: 'Search categories...',
                    hintStyle: const TextStyle(color: Colors.black54, fontSize: 11),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 16, // smaller icon = thinner bar
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: _filterCategories,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 3,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                  _isRandomLoading ? null : _openRandomFood,
                  icon: _isRandomLoading
                      ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.auto_awesome, size: 14),
                  label: const Text(
                    'View Random Recipe of the day',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEF8F5),
                    foregroundColor: const Color(0xFF4A3A32),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _filteredCategories.isEmpty &&
                  _searchQuery.isNotEmpty
                  ? const Center(
                child: Text(
                  'No categories found',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  final category =
                  _filteredCategories[index];
                  return CategoryCard(
                    category: category,
                    onTap: () => _openCategory(category),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
