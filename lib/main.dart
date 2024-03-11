// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/settings_screen.dart';
import 'screens/tabs_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/utils/app_routes.dart';
import 'screens/categories_meals_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;
        return !filterGluten &&
            !filterVegetarian &&
            !filterLactose &&
            !filterVegan;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink[600],
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      home: TabsScreen(
        favoriteMeals: _favoriteMeals,
      ),
      routes: {
        AppRoutes.HOME: (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        AppRoutes.CATEGORIES_MEALS: (context) =>
            CategoriesMealsScreen(meals: _availableMeals),
        AppRoutes.MEAL_DETAIL: (context) => MealDetailScreen(
              isFavorite: _isFavorite,
              onToggleFavorite: _toggleFavorite,
            ),
        AppRoutes.SETTINGS: (context) =>
            SettingsScreens(settings: settings, onSettingsChanged: _filterMeals)
      },
    );
  }
}
