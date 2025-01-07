import 'package:flutter/material.dart';
import 'package:services_app/common/color_extension.dart';
import 'package:services_app/common/extension.dart';
import 'package:services_app/common_widget/round_button.dart';
import 'package:services_app/common_widget/round_textfield.dart';
import 'package:services_app/screens/login/mobile_verify_screen.dart';
import 'package:services_app/screens/login/sign_in_mobile_screen.dart';

import '../../services/api_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _role = 'طالب_خدمة'; // الدور الافتراضي

  void _register() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();


    if (email.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty) {
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
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
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
                          "SignUp",
                          style: TextStyle(
                            color: TColor.title,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        NewRoundTextField(
                          hintText: "First Name",
                          controller: _nameController,
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        NewRoundTextField(
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        NewRoundTextField(
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
                        NewRoundTextField(
                          hintText: "Mobile Number",
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                        ),

                        const SizedBox(
                          height: 15,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: RoundButton(
                              title: "SIGN UP",
                              fontWeight: FontWeight.bold,
                              onPressed: _register),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            "Or Sign Up with",
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
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundButton(
                      title: "SIGN IN",
                      width: context.width * 0.65,
                      type: RoundButtonType.line,
                      onPressed: () {
                        context.pop();
                      }),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
