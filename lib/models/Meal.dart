class Meal {
  final int id;
  final String meal;
  final String thumb;

  const Meal({
    required this.id,
    required this.meal,
    required this.thumb,
  });

  factory Meal.fromJson(Map<String, dynamic> jsonMeal){
    return Meal(
        id : int.parse(jsonMeal['idMeal']),
        meal: jsonMeal['strMeal'] as String,
        thumb: jsonMeal['strMealThumb'] as String,
    );
  }
}
