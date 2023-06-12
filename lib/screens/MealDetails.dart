
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/models/MealDetailed.dart';
import 'package:meal_app/utils/api.dart';

import '../models/Meal.dart';
import '../widgets/CustomDrawer.dart';
import '../widgets/MealsCard.dart';

class MealsList extends StatefulWidget {
  const MealsList({super.key, required this.id});

  final int id;

  @override
  State<StatefulWidget> createState() => _MealsListState();

}

class _MealsListState extends State<MealsList>{
  late Future<MealDetailed> meals;

  @override
  void initState(){
    super.initState();
    meals = fetchSingleMealById(widget.id);
  }

  @override
  Widget build (BuildContext context){
    return FutureBuilder<MealDetailed>(
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