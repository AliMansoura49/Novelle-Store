
import 'package:flutter/material.dart';

abstract class AppColors{

  static const  _seedColor = Color(0xFF0EA5A5);

  static final lightColorScheme  = ColorScheme
      .fromSeed(
      seedColor: _seedColor,
    brightness: Brightness.light
  );

  static final darkColorScheme  = ColorScheme
      .fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark
  );

}

