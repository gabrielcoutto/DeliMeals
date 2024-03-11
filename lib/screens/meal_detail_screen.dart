import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    super.key,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    Widget createSectionTitle({BuildContext? context, String? title}) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title!,
          style: Theme.of(context!).textTheme.titleMedium,
        ),
      );
    }

    Widget createSectionContainer({Widget? child}) {
      return Container(
        width: 330,
        height: 250,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              createSectionTitle(
                title: 'Ingredientes',
                context: context,
              ),
              createSectionContainer(
                child: ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(meal.ingredients[index]),
                      ),
                    );
                  },
                ),
              ),
              createSectionTitle(
                title: 'Passos',
                context: context,
              ),
              createSectionContainer(
                  child: ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      const Divider(),
                    ],
                  );
                },
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
        onPressed: () {
          onToggleFavorite(meal);
        },
        child: Icon(
          isFavorite(meal) ? Icons.star : Icons.star_border_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
