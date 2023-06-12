import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:meal_app/models/Meal.dart';
import 'package:meal_app/models/MealDetailed.dart';
import '../models/CategoryMeal.dart';

Future<List<CategoryMeal>> fetchCategories() async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> categoriesJSON = jsonDecode(response.body);
    var categoriesArr = <CategoryMeal>[];

    for (var x in categoriesJSON['categories']){
      categoriesArr.add(CategoryMeal.fromJson(x));
    }

    return categoriesArr;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load categories');
  }
}

Future<List<Meal>> fetchMealsByCategory(String category) async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));

  if (response.statusCode == 200) {
    Map<String, dynamic> mealsJSON = jsonDecode(response.body);
    var mealsArr = <Meal>[];

    for (var x in mealsJSON['meals']){
      mealsArr.add(Meal.fromJson(x));
    }

    return mealsArr;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load meals');
  }
}

Future<MealDetailed> fetchSingleMealById(int id) async {
  final response = await http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> meal = jsonDecode(response.body);

    return MealDetailed.fromJson(meal['meals'][0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load meals');
  }
}
