class Head {
  final String id;
  final String firstName;
  final String lastName;

  Head({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  // Factory constructor to create a Head object from JSON data
  factory Head.fromJson(Map<String, dynamic> json) {
    return Head(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  // Method to convert a Head object to JSON data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
