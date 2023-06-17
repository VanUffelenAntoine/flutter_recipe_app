
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/utils/api.dart';
import 'package:meal_app/widgets/CustomCachedNetworkImage.dart';
import 'package:meal_app/widgets/CustomDrawer.dart';
import 'package:meal_app/widgets/CustomProgressIndicator.dart';

import '../models/CategoryMeal.dart';
import 'Meals.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<CategoryMeal>> cats;
  String searchValue = "";
  final _suggestions = <String>[];

  ListView filteredSearch(snapshot) {
    if (searchValue != '') {
      final filteredList = <CategoryMeal>[];
      for (var cat in snapshot.data) {
        if (cat.category.toLowerCase().contains(searchValue.toLowerCase())) {
          filteredList.add(cat);
        }
      }

      return ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (BuildContext context, int index) {
            return CategoryCard(cat: filteredList[index], categories: snapshot.data,);
          });
    }
    return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryCard(cat: snapshot.data![index], categories: snapshot.data);
        });
  }

  @override
  void initState() {
    super.initState();
    cats = fetchCategories();
    cats.then((value) {
      for (var cat in value) {
        _suggestions.add(cat.category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryMeal>>(
      future: cats,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: EasySearchBar(
              title: const Text('Categories'),
              onSearch: (value) => setState(() => searchValue = value),
              suggestions: _suggestions,
            ),
            body: Center(child: filteredSearch(snapshot)),
            drawer: const CustomDrawer(),
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

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key, required this.cat, this.categories = const []});

  final CategoryMeal cat;
  final List<CategoryMeal> categories;

  @override
  State<StatefulWidget> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CustomCachedNetworkImage(url: widget.cat.thumb),
            title: Text(widget.cat.category),
            subtitle: const Text('Tap to view recipes'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MealsList(
                            category: widget.cat.category,
                            categories: widget.categories,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
