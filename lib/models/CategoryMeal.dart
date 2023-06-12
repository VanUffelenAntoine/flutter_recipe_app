class CategoryMeal {
  final int id;
  final String category;
  final String thumb;
  final String categoryDescription;

  const CategoryMeal({
    required this.id,
    required this.category,
    required this.thumb,
    required this.categoryDescription
  });

  factory CategoryMeal.fromJson(Map<String, dynamic> jsonMeal){
    return CategoryMeal(
      id : int.parse(jsonMeal['idCategory']),
      category: jsonMeal['strCategory'] as String,
      thumb: jsonMeal['strCategoryThumb'] as String,
      categoryDescription: jsonMeal['strCategoryDescription'] as String
    );
  }
}
