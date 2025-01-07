import 'package:flutter/material.dart';
import 'package:services_app/common/color_extension.dart';
import 'package:services_app/common/extension.dart';

class VerifyMessageScreen extends StatefulWidget {
  const VerifyMessageScreen({super.key});

  @override
  State<VerifyMessageScreen> createState() => _VerifyMessageScreenState();
}

class _VerifyMessageScreenState extends State<VerifyMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/images/otp_bg.png",
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.fitWidth,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: context.width * 0.7,
                fit: BoxFit.fitWidth,
              ),
              const Spacer(),
              Text(
                "You Account\nHas Been Verified\nSuccessfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: TColor.secondary,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/next.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          )
        ],
      ),
    );
  }
}
