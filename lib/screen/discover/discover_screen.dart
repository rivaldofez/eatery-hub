import 'package:eateryhub/data/model/restaurant.dart';
import 'package:eateryhub/provider/discover/restaurant_list_provider.dart';
import 'package:eateryhub/screen/discover/restaurant_card_widget.dart';
import 'package:eateryhub/static/base_result_state.dart';
import 'package:eateryhub/static/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Discover")),
      body: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            LoadingState<List<Restaurant>>() => Center(
              child: CircularProgressIndicator(),
            ),
            LoadedState<List<Restaurant>>(data: var restaurantList) =>
              ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurantList[index];
                  return RestaurantCardWidget(
                    restaurant: restaurant,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: restaurant.id,
                      );
                    },
                  );
                },
              ),
            ErrorState<List<Restaurant>>(error: var message) => Center(
              child: Text(message),
            ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
