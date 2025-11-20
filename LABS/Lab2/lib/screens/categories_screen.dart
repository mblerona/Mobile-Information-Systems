import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/food_details_model.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'food_details_screen.dart';
import 'food_category_screen.dart';

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
      // simple error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load ')),
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
            .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
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
        actions: [
          IconButton(
            onPressed: _isRandomLoading ? null : _openRandomFood,
            icon: _isRandomLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Icon(Icons.shuffle),
            tooltip: 'Random recipe',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [

          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterCategories,
            ),
          ),

          Expanded(
            child: _filteredCategories.isEmpty && _searchQuery.isNotEmpty
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
    );
  }
}
