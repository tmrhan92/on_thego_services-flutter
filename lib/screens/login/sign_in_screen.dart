import 'package:flutter/material.dart';
import 'package:services_app/common/color_extension.dart';
import 'package:services_app/common/extension.dart';
import 'package:services_app/common_widget/round_button.dart';
import 'package:services_app/common_widget/round_textfield.dart';
import 'package:services_app/screens/home/choose_service_screen.dart';
//import 'package:services_app/screens/home/home_screen.dart';
import 'package:services_app/screens/login/sign_in_mobile_screen.dart';
import 'package:services_app/screens/login/sign_up_screen.dart';
import 'package:services_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';
import '../message/chat_message_screen.dart';
//import 'package:services_app/screens/message/chat_message_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 1.1,
            child: Image.asset(
              "assets/images/bg.png",
              width: context.width,
              height: context.height,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: context.width,
            height: context.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    "assets/images/logo2.png",
                    width: context.width * 0.65,
                    fit: BoxFit.fitWidth,
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: TColor.title,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        RoundTextField(
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        RoundTextField(
                          hintText: "Password",
                          obscureText: true,
                          right: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/images/show_pass.png",
                              width: 30,
                            ),
                          ),
                          controller: _passwordController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: RoundButton(
                              title: "SIGN IN",
                              fontWeight: FontWeight.bold,
                              onPressed: _login,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                context.push(const ChatMessageScreen());
                              },
                              child: Text(
                                "Forgot Password |",
                                style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            // TextButton(
                            //   onPressed: () {
                            //     context.push(const SignInMobileScreen());
                            //   },
                            //   child: Text(
                            //     "OTP LOGIN",
                            //     style: TextStyle(
                            //       color: TColor.primaryText,
                            //       fontSize: 15,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Or Sign In with",
                            style: TextStyle(
                              color: TColor.placeholder,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "assets/images/fb.png",
                                width: 70,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "assets/images/google.png",
                                width: 70,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "assets/images/in.png",
                                width: 70,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  RoundButton(
                      title: "SIGNUP",
                      width: context.width * 0.65,
                      type: RoundButtonType.line,
                      onPressed: () {
                        context.push(const SignUpScreen());
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
