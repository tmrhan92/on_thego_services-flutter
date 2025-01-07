import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../services/api_service.dart';

// lib/screens/rating_screen.dart
class RatingScreen extends StatelessWidget {
  final _rating = 0.0;

  Future<void> submitRating(double rating, String bookingId) async {
    await ApiService().post('/ratings', {
      'rating': rating,
      'bookingId': bookingId
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            // Handle rating update
          },
        ),
        ElevatedButton(
          onPressed: () => submitRating(_rating, 'bookingId'),
          child: Text('Submit Rating'),
        ),
      ],
    );
  }
}
