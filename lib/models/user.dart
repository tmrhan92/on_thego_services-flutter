class User {
  final String id;
  final String email;
  final String name;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone = '',
  });

  // دالة لتحويل JSON إلى كائن User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],  // تأكد من أنك تحصل على المعرف الصحيح
      email: json['email'],
      name: json['name'],
      phone: json['phone'] ?? '', // تأكد من وجود القيمة الجديدة
    );
  }
}
