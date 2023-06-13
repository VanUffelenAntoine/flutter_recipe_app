import 'package:flutter/material.dart';
import 'package:meal_app/models/MealDetailed.dart';
import 'package:meal_app/utils/api.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({super.key, required this.id});

  final int id;

  @override
  State<StatefulWidget> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  late Future<MealDetailed> meals;

  @override
  void initState() {
    super.initState();
    meals = fetchSingleMealById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MealDetailed>(
      future: meals,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data!.meal),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Category: ${snapshot.data!.category}'),
                            const SizedBox(height: 10),
                            Text('Origin: ${snapshot.data!.area}'),
                            const SizedBox(height: 10),
                            _ingredientsList(snapshot.data!.ingredientsWMeasure)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 250, maxHeight: 250),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.network(snapshot.data!.thumb),
                                ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Flexible(child: Text(snapshot.data!.instructions))
                      ],
                    )
                  ],
                ),
              ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}

Widget _ingredientsList(ingreds) {
  return SizedBox(
    height: 200,
    width: 125,
    child: ListView.builder(
        itemCount: ingreds.length,
        itemBuilder: (context, index) {
          var ingredsList = ingreds.entries.toList();
          return ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              '$index.  ${ingredsList[index].key}',
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text('${ingredsList[index].value}',
                style: const TextStyle(fontSize: 10)),
          );
        }),
  );
}
