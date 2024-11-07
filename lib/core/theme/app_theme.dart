import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/custom_themes/appbar_theme.dart';
import 'package:whatsapp_clone_app/core/theme/custom_themes/tabbar_theme.dart';
import 'package:whatsapp_clone_app/core/theme/custom_themes/text_theme.dart';


class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'helvetica-regular',
    primaryColor: kColorPrimary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppbarTheme.lightAppbarTheme,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: kColorPrimary.withOpacity(0.3),
      selectionHandleColor: kColorPrimary,
    ),
    tabBarTheme: TTabBarTheme.lightTabBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'helvetica-regular',
    primaryColor: kColorPrimary,
    scaffoldBackgroundColor: kColorBlackBg,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppbarTheme.darkAppbarTheme,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: kColorPrimary.withOpacity(0.3),
      selectionHandleColor: kColorPrimary,
    ),
    tabBarTheme: TTabBarTheme.darkTabBarTheme,
  );
}
