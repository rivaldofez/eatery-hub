import 'package:eateryhub/data/api/api_services.dart';
import 'package:eateryhub/provider/detail/restaurant_detail_provider.dart';
import 'package:eateryhub/provider/discover/restaurant_list_provider.dart';
import 'package:eateryhub/screen/detail/detail_screen.dart';
import 'package:eateryhub/screen/discover/discover_screen.dart';
import 'package:eateryhub/static/navigation_route.dart';
import 'package:eateryhub/style/theme/eateryhub_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiServices>()),
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
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => DiscoverScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          restaurantid: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
