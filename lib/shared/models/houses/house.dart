import 'head.dart';
import 'trait.dart';

class House {
  final String id;
  final String name;
  final String houseColours;
  final String founder;
  final String animal;
  final String element;
  final String ghost;
  final String commonRoom;
  final List<Head> heads;
  final List<Trait> traits;

  House({
    required this.id,
    required this.name,
    required this.houseColours,
    required this.founder,
    required this.animal,
    required this.element,
    required this.ghost,
    required this.commonRoom,
    required this.heads,
    required this.traits,
  });

  // Factory constructor to create a House object from JSON data
  factory House.fromJson(Map<String, dynamic> json) {
    var headsFromJson = json['heads'] as List;
    List<Head> headsList = headsFromJson.map((i) => Head.fromJson(i)).toList();

    var traitsFromJson = json['traits'] as List;
    List<Trait> traitsList = traitsFromJson.map((i) => Trait.fromJson(i)).toList();

    return House(
      id: json['id'],
      name: json['name'],
      houseColours: json['houseColours'],
      founder: json['founder'],
      animal: json['animal'],
      element: json['element'],
      ghost: json['ghost'],
      commonRoom: json['commonRoom'],
      heads: headsList,
      traits: traitsList,
    );
  }

  // Method to convert a House
  // object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'houseColours': houseColours,
      'founder': founder,
      'animal': animal,
      'element': element,
      'ghost': ghost,
      'commonRoom': commonRoom,
      'heads': heads.map((head) => head.toJson()).toList(),
      'traits': traits.map((trait) => trait.toJson()).toList(),
    };
  }
}
