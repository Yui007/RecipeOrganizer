import 'package:flutter/foundation.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _recipes = [];
  String _searchQuery = '';
  String _filterDay = '';

  List<Recipe> get recipes {
    return _recipes
        .where((recipe) =>
            recipe.name.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            (_filterDay.isEmpty || recipe.day == _filterDay))
        .toList();
  }

  Future<void> loadRecipes() async {
    _recipes = await _recipeService.getRecipes();
    notifyListeners();
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _recipeService.addRecipe(recipe);
    await loadRecipes();
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _recipeService.updateRecipe(recipe);
    await loadRecipes();
  }

  Future<void> deleteRecipe(String id) async {
    await _recipeService.deleteRecipe(id);
    await loadRecipes();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilterDay(String day) {
    _filterDay = day;
    notifyListeners();
  }
}