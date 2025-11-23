import 'package:eateryhub/data/model/restaurant.dart';
import 'package:eateryhub/provider/favorite/favorite_icon_provider.dart';
import 'package:eateryhub/provider/favorite/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;

  const FavoriteIconWidget({super.key, required this.restaurant});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    super.initState();

    final favoriteProvider = context.read<FavoriteProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await favoriteProvider.loadRestaurantById(widget.restaurant.id);
      final value = favoriteProvider.checkItemFavorite(widget.restaurant.id);
      favoriteIconProvider.isFavorited = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final favoriteProvider = context.read<FavoriteProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorited;

        if (isFavorited) {
          await favoriteProvider.removeRestaurantById(widget.restaurant.id);
        } else {
          await favoriteProvider.saveRestaurant(widget.restaurant);
        }
        favoriteIconProvider.isFavorited = !isFavorited;
        favoriteProvider.loadFavoriteRestaurants();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorited
            ? Icons.favorite
            : Icons.favorite_outline,
      ),
    );
  }
}
