import 'package:flutter/material.dart';
import '../models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.comment,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'التقييم: ',
                  style: TextStyle(fontSize: 14),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
