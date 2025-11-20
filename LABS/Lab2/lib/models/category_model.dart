class Category {
  final String id;
  final String name;
  final String image;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'] as String,
      name: json['strCategory'] as String,
      image: json['strCategoryThumb'] as String,  // FIXED
      description: json['strCategoryDescription'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'idCategory': id,
    'strCategory': name,
    'strCategoryThumb': image,                // FIXED
    'strCategoryDescription': description,
  };
}