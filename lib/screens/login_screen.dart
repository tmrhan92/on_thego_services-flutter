import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/my-button.dart';
import '../components/squair-tail.dart';
import '../components/textfield.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى ملء جميع الحقول')));
      return;
    }

    try {
      final response = await ApiService().login(email, password);
      print('Login response: $response'); // Debugging line

      final String token = response['token'];
      final String role = response['role'];
      final String userId = response['userId']?.toString() ?? ''; // Safe access

      // Store userId in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      final savedUserId = prefs.getString('userId'); // Check stored value
      print('Saved User ID: $savedUserId');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تسجيل الدخول بنجاح')));
      print('User role: $role'); // Debugging role output

      // Navigate based on role
      if (role == 'طالب_خدمة') {
        Navigator.pushReplacementNamed(context, '/main');
      } else if (role == 'مقدم_خدمة') {
        Navigator.pushReplacementNamed(context, '/addService');
      }
    } catch (e) {
      print('Error during login: $e'); // Print error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل في تسجيل الدخول: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
            ), // Icon
            const SizedBox(height: 50),

            // welcome back, you've been missed!
            Text(
              'Welcome back you\'ve been missed!',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ), // TextStyle
            const SizedBox(height: 50), // username textfield


            MyTextField(
              controller: _emailController,
              hintText: 'البريد الإلكتروني',
              obscureText: false,
            ),
            const SizedBox(height: 20), // username textfield

            MyTextField(
              controller: _passwordController,
              hintText: 'كلمة المرور',
              obscureText: true,
            ),
            const SizedBox(height: 10), // username textfield

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ), // Text
                ],
              ),
            ),
            SizedBox(height: 20), // مساحة بين الأزرار

            MyButton(
              onTap: _login,
              child: 'تسجيل الدخول',

            ),
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ), // Divider
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or continue with', // نص التعبير
                      style: TextStyle(color: Colors.grey[700]),

                    ),
                  ), // Padding
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ), // Divider
                  ),
                ],
              ),
            ),
// مساحة بين الأزرار
            SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google button
                SquareTile(imagePath: 'assets/images/google.png'),
                SizedBox(width: 25,),
                // apple button
                SquareTile(imagePath: 'assets/images/apple.png'),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register'); // تأكد من وجود هذه الشاشة
                  },
                  child: Text('Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
        )
      ),
    );
  }
}
