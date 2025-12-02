import 'ingredient_model.dart';

class FoodDetails {
  final String id;
  final String name;
  final String image;
  final String instructions;
  final String? youtubeUrl;
  final List<Ingredient> ingredients;

  FoodDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    this.youtubeUrl,
  });

  factory FoodDetails.fromJson(Map<String, dynamic> json) {
    List<Ingredient> extractedIngredients = [];


    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty) {
        extractedIngredients.add(
          Ingredient(
            name: ingredient.toString(),
            measure: (measure ?? '').toString(),
          ),
        );
      }
    }

    return FoodDetails(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      image: json['strMealThumb'] as String,
      instructions: json['strInstructions'] as String,
      youtubeUrl: json['strYoutube'] as String?,
      ingredients: extractedIngredients,
    );
  }
}