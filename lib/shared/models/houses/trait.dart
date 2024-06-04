class Trait {
  final String id;
  final String name;

  Trait({
    required this.id,
    required this.name,
  });

  // Factory constructor to create a Trait object from JSON data
  factory Trait.fromJson(Map<String, dynamic> json) {
    return Trait(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert a Trait object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
