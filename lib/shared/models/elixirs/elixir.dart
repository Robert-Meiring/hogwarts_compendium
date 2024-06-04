import 'ingredient.dart';
import 'inventor.dart';

class Elixir {
  final String id;
  final String name;
  final String? effect;
  final String? sideEffects;
  final String? characteristics;
  final String? time;
  final String difficulty;
  final List<Ingredient> ingredients;
  final List<Inventor> inventors;
  final String? manufacturer;

  Elixir({
    required this.id,
    required this.name,
    required this.effect,
    required this.sideEffects,
    required this.characteristics,
    required this.time,
    required this.difficulty,
    required this.ingredients,
    required this.inventors,
    required this.manufacturer,
  });

  // Factory constructor to create an Elixir object from JSON data
  factory Elixir.fromJson(Map<String, dynamic> json) {
    var ingredientsFromJson = json['ingredients'] as List;
    List<Ingredient> ingredientsList =
        ingredientsFromJson.map((i) => Ingredient.fromJson(i)).toList();

    var inventorsFromJson = json['inventors'] as List;
    List<Inventor> inventorsList =
        inventorsFromJson.map((i) => Inventor.fromJson(i)).toList();

    return Elixir(
      id: json['id'],
      name: json['name'],
      effect: json['effect'],
      sideEffects: json['sideEffects'],
      characteristics: json['characteristics'],
      time: json['time'],
      difficulty: json['difficulty'],
      ingredients: ingredientsList,
      inventors: inventorsList,
      manufacturer: json['manufacturer'],
    );
  }

  // Method to convert an Elixir object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'effect': effect,
      'sideEffects': sideEffects,
      'characteristics': characteristics,
      'time': time,
      'difficulty': difficulty,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'inventors': inventors.map((inventor) => inventor.toJson()).toList(),
      'manufacturer': manufacturer,
    };
  }
}
