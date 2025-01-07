class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final int duration;
  final String serviceType;
  final String subCategory;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.serviceType,
    required this.subCategory,
  });

  // دالة fromJson لتحويل JSON إلى كائن Service
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      serviceType: json['serviceType'],
      subCategory: json['subCategory'],
    );
  }
}