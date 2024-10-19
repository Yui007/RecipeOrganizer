import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';
import '../widgets/edit_recipe_form.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => EditRecipeForm(recipe: recipe),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Recipe'),
                  content: Text('Are you sure you want to delete this recipe?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text('Delete'),
                      onPressed: () {
                        context.read<RecipeProvider>().deleteRecipe(recipe.id);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe.imageUrl != null)
              Image.file(
                File(recipe.imageUrl!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text('Description:', style: Theme.of(context).textTheme.headline6),
            Text(recipe.description),
            SizedBox(height: 16),
            Text('Ingredients:', style: Theme.of(context).textTheme.headline6),
            ...recipe.ingredients.map((ingredient) => Text('• $ingredient')),
            SizedBox(height: 16),
            Text('Instructions:', style: Theme.of(context).textTheme.headline6),
            Text(recipe.instructions),
            SizedBox(height: 16),
            Text('Day: ${recipe.day}', style: Theme.of(context).textTheme.subtitle1),
          ],
        ),
      ),
    );
  }
}