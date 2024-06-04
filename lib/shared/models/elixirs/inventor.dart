class Inventor {
  final String id;
  final String? firstName;
  final String lastName;

  Inventor({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  // Factory constructor to create an Inventor object from JSON data
  factory Inventor.fromJson(Map<String, dynamic> json) {
    return Inventor(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  // Method to convert an Inventor object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
