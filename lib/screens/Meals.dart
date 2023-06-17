import 'package:flutter/material.dart';
import 'package:meal_app/models/CategoryMeal.dart';
import 'package:meal_app/utils/api.dart';
import 'package:meal_app/widgets/CustomProgressIndicator.dart';

import '../models/Meal.dart';
import '../widgets/CustomDrawer.dart';
import '../widgets/MealsCard.dart';

class MealsList extends StatefulWidget {
  const MealsList(
      {super.key,
      required this.category,
      this.drawer = false,
      this.categories = const []});

  final String category;
  final bool drawer;
  final List<CategoryMeal> categories;

  @override
  State<StatefulWidget> createState() => _MealsListState();
}

class _MealsListState extends State<MealsList> {
  late Future<List<Meal>> meals;
  late String dropdownValue;
  late String category;

  @override
  void initState() {
    super.initState();
    meals = fetchMealsByCategory(widget.category);
    if (widget.categories.isNotEmpty)dropdownValue = widget.categories.first.category;
    category = widget.category;
  }

  getNewMeals(cat) {
    meals = fetchMealsByCategory(cat);
  }

   setDropDownTitle(BuildContext context){
    if (widget.categories.isEmpty){
      return AppBar(title: Text('Recipes for ${widget.category}'),);
    }

    return AppBar(
      title: Text('Recipes for $category'),
      actions: [
        IconButton(onPressed: (){
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Change category: '),
              content: StatefulBuilder(builder: (BuildContext context,StateSetter setState){
                return DropdownButton(
                    isExpanded: true,
                    value: dropdownValue,
                    onChanged: (String? value){
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: widget.categories.map((e) {
                      return DropdownMenuItem(
                          value: e.category,
                          child: Text(e.category));
                    }).toList()
                );
            }),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    setState((){
                      meals = fetchMealsByCategory(dropdownValue);
                      category = dropdownValue;
                      Navigator.pop(context, 'ok');
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
            , icon: const Icon(Icons.sort))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
      future: meals,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: setDropDownTitle(context),
            body: Center(
                child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MealsCard(meal: snapshot.data![index]);
                    })),
            drawer: widget.drawer ? const CustomDrawer() : null,
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
