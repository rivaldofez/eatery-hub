import 'package:eateryhub/screen/detail/detail_screen.dart';
import 'package:eateryhub/screen/home/discover_screen.dart';
import 'package:eateryhub/style/theme/eateryhub_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: DetailScreen(),
    );
  }
}
