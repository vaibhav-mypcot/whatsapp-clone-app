import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';

class TTabBarTheme {
  // -- Light Theme
  static TabBarTheme lightTabBarTheme = const TabBarTheme(
    indicatorColor: kColorWhite,
    dividerColor: Colors.transparent,
    labelColor: kColorWhite,
    unselectedLabelColor: Colors.grey,
  );

  // -- Dark Theme
  static TabBarTheme darkTabBarTheme = const TabBarTheme(
    indicatorColor: kColorPrimary,
    dividerColor: Colors.transparent,
    labelColor: kColorPrimary,
    unselectedLabelColor: Colors.grey,
  );
}
