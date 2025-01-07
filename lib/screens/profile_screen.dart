import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            SizedBox(height: 20),
            Text('اسم المستخدم'),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('الإعدادات'),
              onTap: () {
                // التنقل إلى صفحة الإعدادات
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('سجل الحجوزات'),
              onTap: () {
                // التنقل إلى صفحة سجل الحجوزات
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('تسجيل الخروج'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
