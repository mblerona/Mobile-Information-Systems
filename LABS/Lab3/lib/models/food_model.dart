class Food {
  final String id;
  final String name;
  final String image;
  final String? category;

  Food({
    required this.id,
    required this.name,
    required this.image,
    this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      image: json['strMealThumb'] as String,
      category: json['strCategory'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strMealThumb': image,
    'strCategory': category,
  };
}