class Spell {
  final String id;
  final String name;
  final String? incantation;
  final String effect;
  final bool? canBeVerbal;
  final String type;
  final String light;
  final String? creator;

  Spell({
    required this.id,
    required this.name,
    required this.incantation,
    required this.effect,
    required this.canBeVerbal,
    required this.type,
    required this.light,
    required this.creator,
  });

  // Factory constructor to create a Spell object from JSON data
  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      id: json['id'],
      name: json['name'],
      incantation: json['incantation'],
      effect: json['effect'],
      canBeVerbal: json['canBeVerbal'],
      type: json['type'],
      light: json['light'],
      creator: json['creator'],
    );
  }

  // Method to convert a Spell object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'incantation': incantation,
      'effect': effect,
      'canBeVerbal': canBeVerbal,
      'type': type,
      'light': light,
      'creator': creator,
    };
  }
}
