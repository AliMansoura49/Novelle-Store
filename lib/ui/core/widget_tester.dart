import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/core/theme/theme.dart';
import 'package:store/ui/features/signup/view_model/signup_view_model.dart';
import 'package:store/ui/features/signup/widgets/signup_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
      create: (_)=>SignupViewModel(),
      child: SignupScreen(),
    ),
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    themeMode: ThemeMode.system,
    )
  );
}
