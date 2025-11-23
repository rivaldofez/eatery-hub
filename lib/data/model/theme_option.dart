import 'package:flutter/material.dart';

enum ThemeOption {
  light("light", ThemeMode.light),
  dark("dark", ThemeMode.dark),
  system("system", ThemeMode.system);

  final String value;
  final ThemeMode mode;

  const ThemeOption(this.value, this.mode);
}
