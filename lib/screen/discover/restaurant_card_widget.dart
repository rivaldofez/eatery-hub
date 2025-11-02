import 'package:eateryhub/data/model/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantCardWidget extends StatelessWidget {
  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  final Restaurant restaurant;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  fit: BoxFit.cover,
                  "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.city,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 20),
                        Text(
                          "${restaurant.rating} / 5.0",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Text(
                      restaurant.description,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
