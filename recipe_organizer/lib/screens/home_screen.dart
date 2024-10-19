import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/weekly_view.dart';
import '../widgets/add_recipe_form.dart';
import '../providers/recipe_provider.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Organizer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(context.read<RecipeProvider>()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBar(),
          Expanded(child: const WeeklyView()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddRecipeForm(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}