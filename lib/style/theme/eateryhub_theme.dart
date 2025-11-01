import 'package:eateryhub/style/colors/eateryhub_colors.dart';
import 'package:eateryhub/style/typography/eateryhub_text_styles.dart';
import 'package:flutter/material.dart';

class EateryhubTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: EateryhubTextStyles.displayLarge,
      displayMedium: EateryhubTextStyles.displayMedium,
      displaySmall: EateryhubTextStyles.displaySmall,
      headlineLarge: EateryhubTextStyles.headlineLarge,
      headlineMedium: EateryhubTextStyles.headlineMedium,
      headlineSmall: EateryhubTextStyles.headlineSmall,
      titleLarge: EateryhubTextStyles.titleLarge,
      titleMedium: EateryhubTextStyles.titleMedium,
      titleSmall: EateryhubTextStyles.titleSmall,
      bodyLarge: EateryhubTextStyles.bodyLargeBold,
      bodyMedium: EateryhubTextStyles.bodyLargeMedium,
      bodySmall: EateryhubTextStyles.bodyLargeRegular,
      labelLarge: EateryhubTextStyles.labelLarge,
      labelMedium: EateryhubTextStyles.labelMedium,
      labelSmall: EateryhubTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(toolbarTextStyle: _textTheme.titleLarge);
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: EateryhubColors.ferrariRed.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: EateryhubColors.ferrariRed.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }
}
