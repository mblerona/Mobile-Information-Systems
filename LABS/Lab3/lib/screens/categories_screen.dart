import 'package:flutter/material.dart';

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
        const SnackBar(content: Text('Failed to load')),
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
          const SnackBar(content: Text('No random recipe found')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isRandomLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load random recipe')),
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
        title: Text(widget.title),
        backgroundColor: const Color(0xFFFEF8F5),
        actions: [
          // View Favorites button (stays in AppBar)
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              ).then((_) {
                setState(() {}); // refresh after coming back
              });
            },
            icon: const Icon(
              Icons.favorite,
              color: Color(0xFF4A3A32),
            ),
            label: const Text(
              'View Favorites',
              style: TextStyle(
                color: Color(0xFF4A3A32),
                fontWeight: FontWeight.w600,
              ),
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
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  hintStyle: const TextStyle(color: Colors.black54),
                  prefixIcon:
                  const Icon(Icons.search, color: Colors.black),
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

            // Random of the day button (full width row)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                  _isRandomLoading ? null : _openRandomFood,
                  icon: _isRandomLoading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.auto_awesome),
                  label: const Text(
                    'View Random Recipe of the day',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEF8F5),
                    foregroundColor: const Color(0xFF4A3A32),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            // Categories list
            Expanded(
              child: _filteredCategories.isEmpty &&
                  _searchQuery.isNotEmpty
                  ? const Center(
                child: Text(
                  'No categories found',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories[index];
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
