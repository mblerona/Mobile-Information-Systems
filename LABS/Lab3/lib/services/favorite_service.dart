import '../models/food_model.dart';

class FavoriteService {
  static final List<Food> _favorites = [];

  static List<Food> get favorites => List.unmodifiable(_favorites);

  static bool isFavorite(Food food) {
    return _favorites.any((f) => f.id == food.id);
  }

  static void toggleFavorite(Food food) {
    final index = _favorites.indexWhere((f) => f.id == food.id);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(food);
    }
  }
}
