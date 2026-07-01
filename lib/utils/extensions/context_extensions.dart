// Flutter packages
import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  Brightness get brightness => theme.brightness;
  bool get isDark => theme.brightness == Brightness.dark;

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get deviceSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // Navigation
  NavigatorState get navigator => Navigator.of(this);

  // Scaffold / Snackbar
  ScaffoldMessengerState get scaffold => ScaffoldMessenger.of(this);

  void showSnackBar(String message, {Color? color}) => scaffold
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
}
