import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function() onTap;
  final String child;

  const MyButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ), // BoxDecoration
        child: Center(
          child: Text(
            child,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ), // TextStyle
          ),
        ), // Center
      ),
    ); // GestureDetector
  }
}
