import 'package:eateryhub/data/api/api_services.dart';
import 'package:eateryhub/data/local/local_database_service.dart';
import 'package:eateryhub/data/local/shared_preferences_service.dart';
import 'package:eateryhub/provider/detail/restaurant_detail_provider.dart';
import 'package:eateryhub/provider/discover/restaurant_list_provider.dart';
import 'package:eateryhub/provider/favorite/favorite_provider.dart';
import 'package:eateryhub/provider/main/bottom_nav_provider.dart';
import 'package:eateryhub/provider/search/restaurant_search_provider.dart';
import 'package:eateryhub/provider/settings/settings_provider.dart';
import 'package:eateryhub/screen/detail/detail_screen.dart';
import 'package:eateryhub/screen/main/main_screen.dart';
import 'package:eateryhub/screen/search/search_screen.dart';
import 'package:eateryhub/static/navigation_route.dart';
import 'package:eateryhub/style/theme/eateryhub_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantSearchProvider(context.read<ApiServices>()),
        ),
        Provider(create: (context) => LocalDatabaseService()),
        ChangeNotifierProvider(
          create: (context) =>
              FavoriteProvider(context.read<LocalDatabaseService>()),
        ),
        Provider(create: (context) => SharedPreferencesService(prefs)),
        ChangeNotifierProvider(
          create: (context) =>
              SettingsProvider(context.read<SharedPreferencesService>())
                ..getThemeOption(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: EateryhubTheme.lightTheme,
      darkTheme: EateryhubTheme.darkTheme,
      themeMode: context.watch<SettingsProvider>().themeOption?.mode,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          restaurantid: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.searchRoute.name: (context) => SearchScreen(),
      },
    );
  }
}
