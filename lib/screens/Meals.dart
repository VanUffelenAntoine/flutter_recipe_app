
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/utils/api.dart';

import '../models/Meal.dart';
import '../widgets/CustomDrawer.dart';
import '../widgets/MealsCard.dart';

class MealsList extends StatefulWidget {
  const MealsList({super.key, required this.category});

  final String category;

  @override
  State<StatefulWidget> createState() => _MealsListState();

}

class _MealsListState extends State<MealsList>{
  late Future<List<Meal>> meals;
  
  @override
  void initState(){
    print(widget.category);
    super.initState();
    meals = fetchMealsByCategory(widget.category);
  }
  
  @override
  Widget build (BuildContext context){
    return FutureBuilder<List<Meal>>(
      future: meals,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Recipes for CategoryName'),
            ),
            body: Center(
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsCard(meal: snapshot.data![index]);
                    })),
            drawer: const CustomDrawer(),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}