import 'package:meal_app/models/Meal.dart';

class MealDetailed extends Meal {
  final String category;
  final String area;
  final String instructions;
  final String ytbLink;
  Map<String, String> ingredientsWMeasure = {};

  MealDetailed({
    required super.id,
    required super.meal,
    required super.thumb,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ytbLink,
  });

  @override
  factory MealDetailed.fromJson(Map<String, dynamic> jsonMeal) {
    MealDetailed meal = MealDetailed(
        id: int.parse(jsonMeal['idMeal']),
        meal: jsonMeal['strMeal'] as String,
        thumb: jsonMeal['strMealThumb'] as String,
        category: jsonMeal['strCategory'] as String,
        area: jsonMeal['strArea'] as String,
        instructions: jsonMeal['strInstructions'] as String,
        ytbLink: jsonMeal['strYoutube'] as String);
    meal.addIngredientsFromJson(jsonMeal);
    return meal;
  }

  void addIngredientsFromJson(jsonMeal) {
    for (var i = 1; i <= 21; i++) {
      if (jsonMeal['strIngredient$i'] == null ||
          jsonMeal['strMeasure$i'] == null) {
        break;
      }
      ingredientsWMeasure
          .addAll({jsonMeal['strIngredient$i']: jsonMeal['strMeasure$i']});
    }
    ingredientsWMeasure.remove('');
  }
}
