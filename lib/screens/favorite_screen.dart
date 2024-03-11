import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: favoriteMeals.isEmpty
            ? const Center(
                child: Text('Nenhuma refeição favorita adicionada!'),
              )
            : ListView.builder(
                itemCount: favoriteMeals.length,
                itemBuilder: (ctx, index) {
                  return MealItem(meal: favoriteMeals[index]);
                },
              ));
  }
}
