class Ingredient {
  final String id;
  final String name;

  Ingredient({
    required this.id,
    required this.name,
  });

  // Factory constructor to create an Ingredient object from JSON data
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert an Ingredient object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
