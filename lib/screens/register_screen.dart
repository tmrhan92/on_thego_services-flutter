import 'package:flutter/material.dart';
import '../components/my-button.dart';
import '../components/textfield.dart';
import '../services/api_service.dart'; // تأكد من استيراد خدمة API

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _role = 'طالب_خدمة'; // الدور الافتراضي

  void _register() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      _showSnackBar('يرجى ملء جميع الحقول');
      return;
    }

    try {
      await ApiService().register(email, password, name, _role);
      _showSnackBar('نجاح التسجيل');
      Navigator.pop(context); // العودة إلى الشاشة السابقة
    } catch (e) {
      _showSnackBar('فشل في التسجيل: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  size: 100,
                ), // أيقونة
                const SizedBox(height: 20),

                // رسالة الترحيب
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30), // مسافة

                // حقول الإدخال
                MyTextField(
                  controller: _nameController,
                  hintText: 'الاسم',
                  obscureText: false,
                ),
                const SizedBox(height: 12),
                MyTextField(
                  controller: _emailController,
                  hintText: 'البريد الإلكتروني',
                  obscureText: false,
                ),
                const SizedBox(height: 12),
                MyTextField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: 'كلمة المرور',
                ),
                const SizedBox(height: 12),

                // زر اختيار الدور
                DropdownButtonFormField<String>(
                  value: _role,
                  onChanged: (String? newValue) {
                    setState(() {
                      _role = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "الدور",
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['طالب_خدمة', 'مقدم_خدمة']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.blue),),

                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // زر التسجيل
                MyButton(
                  onTap: _register,
                  child: 'تسجيل',
                ),
              ],
            ),
          ),
        ),
    );
  }
}
