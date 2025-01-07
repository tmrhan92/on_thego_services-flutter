import 'package:flutter/material.dart';
import 'package:services_app/screens/review_card.dart';

import '../models/review.dart';
import '../services/api_service.dart';


class ReviewsScreen extends StatelessWidget {
  final String therapistId;

  ReviewsScreen({required this.therapistId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('التقييمات والمراجعات')),
      body: FutureBuilder<List<Review>>(
        future: ApiService().getTherapistReviews(therapistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ'));
          } else {
            final reviews = snapshot.data!;
            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ReviewCard(review: reviews[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddReviewDialog(context),
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('إضافة تقييم جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'التعليق',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('التقييم: '),
                SizedBox(width: 8),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: () {
                        // Handle rating selection
                      },
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('إلغاء'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('إضافة'),
            onPressed: () {
              // Handle review submission
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
