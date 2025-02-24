import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(4),
        decoration:BoxDecoration(
      border: Border.all(color: Colors.white),
     borderRadius: BorderRadius.circular(16),
     color: Colors.grey[200],
        ),
     child: Image.asset(imagePath),
      height: 80,
    );
  }
}
