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
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withAlpha(80)
                  : Colors.black.withAlpha(80),
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Material(
          color: const Color.fromARGB(0, 253, 246, 246),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
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
                        children: [
                          const Icon(Icons.star, size: 20),
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
      ),
    );
  }
}
