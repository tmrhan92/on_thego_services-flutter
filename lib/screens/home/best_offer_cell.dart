import 'package:flutter/material.dart';

class BestOfferCell extends StatelessWidget {
  final Map<String, String> obj; // البيانات الخاصة بالعروض
  final VoidCallback onPressed; // المعامل عند الضغط

  const BestOfferCell({
    Key? key,
    required this.obj,
    required this.onPressed, // تأكد من إضافة هذا المُعامل
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // استخدم onPressed عند الضغط
      child: Container(
        width: 150, // يمكنك ضبط العرض وفق الحاجة
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              obj["img"] ?? '', // تأكد أن المفتاح يتطابق مع الكود
              fit: BoxFit.cover,
              height: 80,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                obj["title"] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                obj["subtitle"] ?? '',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
