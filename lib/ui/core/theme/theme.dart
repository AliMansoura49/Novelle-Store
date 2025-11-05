
import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTheme{

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    useMaterial3: true
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    useMaterial3: true
  );
}