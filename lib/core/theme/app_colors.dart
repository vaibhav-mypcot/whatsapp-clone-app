import 'package:flutter/material.dart';


  // App basic colors
   const Color kColorPrimary = Color(0xFF00A884);
   const Color kColorSecondary = Color(0xFF00A884);
   const Color kColorAccent = Color(0xFF00A884);

  // Gradient colors
   Gradient kDarkGradientBackgroundColor = LinearGradient(
    colors: [
      kColorBlackBg, // bottom color
      kColorBlackBg.withOpacity(0),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: const [0.70, 1.0],
  );

   Gradient kLightGradientBackgroundColor = LinearGradient(
    colors: [
      kColorWhiteBg, // bottom color
      kColorWhiteBg.withOpacity(0),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: const [0.70, 1.0],
  );

  // Text colors

  // Background colors
   const Color kColorBlackBg = Color(0xff121b22);
   const Color kColorWhiteBg = Color(0xFFFFFFFF);

  // Background container color
   const Color kColorPineGreen = Color(0xFF008069);

  // Button colors

  //Border colors

  // Error and validation color

  // Neutral shades
   const Color kColorBlack = Color(0xFF000000);
   const Color kColorDarkGray = Color(0xFF333333);
   const Color kColorLightGray = Color(0xFFBBBBBB);
   const Color kColorWhite = Color(0xFFFFFFFF);
   const Color kColorGreyBg = Color(0XFF1F2C34);

