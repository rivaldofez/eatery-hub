import 'package:eateryhub/data/model/detail_restaurant.dart';
import 'package:eateryhub/provider/detail/restaurant_detail_provider.dart';
import 'package:eateryhub/screen/detail/body_detail_screen_widget.dart';
import 'package:eateryhub/static/base_result_state.dart';
import 'package:eateryhub/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantid;

  const DetailScreen({super.key, required this.restaurantid});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;
    context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
      widget.restaurantid,
    );
  });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: Text("Detail Restaurant")),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              LoadingState<DetailRestaurant>() => const Center(
                child: CircularProgressIndicator(),
              ),

              LoadedState<DetailRestaurant>(data: var detailRestaurant) =>
                BodyOfDetailScreenWidget(detailRestaurant: detailRestaurant),
                
              ErrorState<DetailRestaurant>(error: var message) => ErrorCard(message: message),

              _ => SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
