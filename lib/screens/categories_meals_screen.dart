import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/category.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  const CategoriesMealsScreen({super.key, this.meals});

  final List<Meal>? meals;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;
    final categoryMeals = meals!.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).canvasColor),
        child: Center(
          child: ListView.builder(
            itemCount: categoryMeals.length,
            itemBuilder: (context, index) {
              final meal = categoryMeals[index];
              return MealItem(meal: meal);
            },
          ),
        ),
      ),
    );
  }
}
