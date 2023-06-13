
import 'package:flutter/material.dart';
import 'package:meal_app/utils/api.dart';
import 'package:meal_app/widgets/CustomProgressIndicator.dart';

import '../models/Meal.dart';
import '../widgets/CustomDrawer.dart';
import '../widgets/MealsCard.dart';

class MealsList extends StatefulWidget {
  const MealsList({super.key, required this.category, this.drawer = false});

  final String category;
  final bool drawer;

  @override
  State<StatefulWidget> createState() => _MealsListState();

}

class _MealsListState extends State<MealsList>{
  late Future<List<Meal>> meals;
  
  @override
  void initState(){
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
              title: Text('Recipes for ${widget.category}'),
            ),
            body: Center(
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsCard(meal: snapshot.data![index]);
                    })),
            drawer: widget.drawer? const CustomDrawer() : null,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return CustomProgressIndicator();
      },
    );
  }
}