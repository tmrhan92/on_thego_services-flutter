class Therapist {
  final String id;
  final String name;
  final String serviceType;
  final String bio;

  Therapist({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.bio,
  });

  factory Therapist.fromJson(Map<String, dynamic> json) {
    return Therapist(
      id: json['_id'],
      name: json['name'],
      serviceType: json['serviceType'],
      bio: json['bio'],
    );
  }
}
