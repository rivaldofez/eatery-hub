import 'package:eateryhub/data/model/detail_restaurant.dart';
import 'package:flutter/material.dart';

class DetailReviewTabPage extends StatelessWidget {
  const DetailReviewTabPage({super.key, required this.reviews});

  final List<CustomerReview> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(review.name, style: Theme.of(context).textTheme.bodyMedium),
              Text(review.review, style: Theme.of(context).textTheme.bodySmall),
              Text(review.date, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        );
      },
    );
  }
}
