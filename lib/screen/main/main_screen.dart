import 'package:eateryhub/provider/main/bottom_nav_provider.dart';
import 'package:eateryhub/screen/discover/discover_screen.dart';
import 'package:eateryhub/screen/favorite/favorite_screen.dart';
import 'package:eateryhub/screen/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const DiscoverScreen(),
            1 => const FavoriteScreen(),
            _ => const SettingsScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<BottomNavProvider>().indexBottomNavBar,
        onTap: (index) {
          context.read<BottomNavProvider>().setIndexBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Discover",
            tooltip: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
            tooltip: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            tooltip: "Settings",
          ),
        ],
      ),
    );
  }
}
