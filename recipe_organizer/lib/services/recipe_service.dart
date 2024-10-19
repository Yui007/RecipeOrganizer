import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';

class RecipeService {
  static const String _storageKey = 'recipes';

  Future<List<Recipe>> getRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recipesJson = prefs.getString(_storageKey);
    if (recipesJson == null) return [];
    final List<dynamic> recipesList = json.decode(recipesJson);
    return recipesList.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<void> addRecipe(Recipe recipe) async {
    final recipes = await getRecipes();
    recipes.add(recipe);
    await _saveRecipes(recipes);
  }

  Future<void> updateRecipe(Recipe updatedRecipe) async {
    final recipes = await getRecipes();
    final index = recipes.indexWhere((r) => r.id == updatedRecipe.id);
    if (index != -1) {
      recipes[index] = updatedRecipe;
      await _saveRecipes(recipes);
    }
  }

  Future<void> deleteRecipe(String id) async {
    final recipes = await getRecipes();
    recipes.removeWhere((r) => r.id == id);
    await _saveRecipes(recipes);
  }

  Future<void> _saveRecipes(List<Recipe> recipes) async {
    final prefs = await SharedPreferences.getInstance();
    final String recipesJson = json.encode(recipes.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, recipesJson);
  }
}