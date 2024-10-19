import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class AddRecipeForm extends StatefulWidget {
  const AddRecipeForm({Key? key}) : super(key: key);

  @override
  _AddRecipeFormState createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  String _ingredients = '';
  String _instructions = '';
  String _day = 'Monday';
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Recipe Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a recipe name';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Description'),
                      onSaved: (value) => _description = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Ingredients (comma-separated)'),
                      onSaved: (value) => _ingredients = value!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Instructions'),
                      maxLines: 3,
                      onSaved: (value) => _instructions = value!,
                    ),
                    DropdownButtonFormField<String>(
                      value: _day,
                      decoration: const InputDecoration(labelText: 'Day'),
                      items: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
                          .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                          .toList(),
                      onChanged: (value) => setState(() => _day = value!),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _getImage,
                      child: const Text('Add Image'),
                    ),
                    if (_image != null) ...[
                      const SizedBox(height: 8),
                      Image.file(_image!, height: 100),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final newRecipe = Recipe(
                            id: DateTime.now().toString(),
                            name: _name,
                            description: _description,
                            ingredients: _ingredients.split(',').map((e) => e.trim()).toList(),
                            instructions: _instructions,
                            day: _day,
                            imageUrl: _image?.path,
                          );
                          context.read<RecipeProvider>().addRecipe(newRecipe);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add Recipe'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}