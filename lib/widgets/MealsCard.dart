import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Meal.dart';

class MealsCard extends StatefulWidget {
  const MealsCard({super.key, required this.meal});

  final Meal meal;

  @override
  State<StatefulWidget> createState() => _MealsCardState();
}

class _MealsCardState extends State<MealsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(widget.meal.thumb),
            title: Text(widget.meal.meal),
            subtitle: const Text('Tap to view details'),
          ),
        ],
      ),
    );
  }
}