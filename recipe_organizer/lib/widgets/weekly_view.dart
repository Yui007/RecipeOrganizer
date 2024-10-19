import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../widgets/day_column.dart';
import '../providers/recipe_provider.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final recipes = recipeProvider.recipes;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: Text('All'),
                  selected: recipeProvider._filterDay.isEmpty,
                  onSelected: (selected) {
                    if (selected) {
                      recipeProvider.setFilterDay('');
                    }
                  },
                ),
                ...['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                    .map((day) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilterChip(
                            label: Text(day),
                            selected: recipeProvider._filterDay == day,
                            onSelected: (selected) {
                              if (selected) {
                                recipeProvider.setFilterDay(day);
                              } else {
                                recipeProvider.setFilterDay('');
                              }
                            },
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              DayColumn(day: 'Monday', recipes: recipes.where((r) => r.day == 'Monday').toList()),
              DayColumn(day: 'Tuesday', recipes: recipes.where((r) => r.day == 'Tuesday').toList()),
              DayColumn(day: 'Wednesday', recipes: recipes.where((r) => r.day == 'Wednesday').toList()),
              DayColumn(day: 'Thursday', recipes: recipes.where((r) => r.day == 'Thursday').toList()),
              DayColumn(day: 'Friday', recipes: recipes.where((r) => r.day == 'Friday').toList()),
              DayColumn(day: 'Saturday', recipes: recipes.where((r) => r.day == 'Saturday').toList()),
              DayColumn(day: 'Sunday', recipes: recipes.where((r) => r.day == 'Sunday').toList()),
            ],
          ),
        ),
      ],
    );
  }
}