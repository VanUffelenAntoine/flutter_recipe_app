import 'package:meal_app/models/Meal.dart';

class MealDetailed extends Meal {
  final String category;
  final String area;
  final String instructions;
  Map<String, String> ingredientsWMeasure = {};

  MealDetailed({
    required super.id,
    required super.meal,
    required super.thumb,
    required this.category,
    required this.area,
    required this.instructions,
  });

  @override
  factory MealDetailed.fromJson(Map<String, dynamic> jsonMeal) {
    return MealDetailed(
      id: int.parse(jsonMeal['idMeal']),
      meal: jsonMeal['strMeal'] as String,
      thumb: jsonMeal['strMealThumb'] as String,
      category: jsonMeal['strCategory'] as String,
      area: jsonMeal['strArea'] as String,
      instructions: jsonMeal['strInstructions'] as String,
    );
  }
}
