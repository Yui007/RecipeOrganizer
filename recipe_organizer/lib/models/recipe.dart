import 'dart:convert';

class Recipe {
  final String id;
  final String name;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final String day;
  final String? imageUrl;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.day,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'ingredients': ingredients,
    'instructions': instructions,
    'day': day,
    'imageUrl': imageUrl,
  };

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    ingredients: List<String>.from(json['ingredients']),
    instructions: json['instructions'],
    day: json['day'],
    imageUrl: json['imageUrl'],
  );
}