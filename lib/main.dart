import 'package:eateryhub/data/api/api_services.dart';
import 'package:eateryhub/provider/discover/restaurant_list_provider.dart';
import 'package:eateryhub/screen/detail/detail_screen.dart';
import 'package:eateryhub/screen/discover/discover_screen.dart';
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
      home: DiscoverScreen(),
    );
  }
}
