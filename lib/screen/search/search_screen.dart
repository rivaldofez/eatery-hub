import 'dart:async';

import 'package:eateryhub/data/model/restaurant.dart';
import 'package:eateryhub/provider/search/restaurant_search_provider.dart';
import 'package:eateryhub/screen/discover/restaurant_card_widget.dart';
import 'package:eateryhub/static/base_result_state.dart';
import 'package:eateryhub/static/navigation_route.dart';
import 'package:eateryhub/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final provider = Provider.of<RestaurantSearchProvider>(
        context,
        listen: false,
      );
      provider.fetchSearchRestaurantList(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Masukkan kata kunci...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          Consumer<RestaurantSearchProvider>(
            builder: (context, provider, _) {
              final state = provider.resultState;

              return switch (state) {
                LoadingState<List<Restaurant>>() => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                ),

                LoadedState<List<Restaurant>>(data: var list) => SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final restaurant = list[index];
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
                  }, childCount: list.length),
                ),

                ErrorState<List<Restaurant>>(error: var message) =>
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: ErrorCard(message: message),
                  ),

                _ => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('Cari restoran favoritmu...')),
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
