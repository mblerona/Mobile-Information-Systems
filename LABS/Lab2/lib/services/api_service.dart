import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../models/food_model.dart';
import '../models/food_details_model.dart';

class ApiService {

  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';


  Future<List<Category>> getCategories() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/categories.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List categoriesJson = data['categories'] ?? [];

      return categoriesJson
          .map((item) => Category.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }







  Future<List<Food>> getFoodByCategory(String categoryName) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/filter.php?c=${Uri.encodeQueryComponent(categoryName)}',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List mealsJson = data['meals'] ?? [];

      return mealsJson
          .map((item) => Food.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load meals for this category');
    }
  }


  Future<List<Food>> searchFood(String query) async {
    if (query.trim().isEmpty) return [];

    final response = await http.get(
      Uri.parse(
        '$_baseUrl/search.php?s=${Uri.encodeQueryComponent(query)}',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? mealsJson = data['meals'];

      if (mealsJson == null) return [];

      return mealsJson
          .map((item) => Food.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }


  Future<FoodDetails?> getFoodDetails(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/lookup.php?i=$id'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? meals = data['meals'];

      if (meals == null || meals.isEmpty) return null;

      return FoodDetails.fromJson(meals[0]);
    } else {
      throw Exception('Failed to load food details');
    }
  }


  Future<FoodDetails?> getRandomFood() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/random.php'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? meals = data['meals'];

      if (meals == null || meals.isEmpty) return null;

      return FoodDetails.fromJson(meals[0]);
    } else {
      throw Exception('Failed to load random food');
    }
  }
}
