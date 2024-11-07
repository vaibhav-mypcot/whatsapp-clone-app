import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/services/shared_preferences_service.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/page/phone_number_screen.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/dashboard_screen/presentation/page/dashboard_screen.dart';
import 'package:whatsapp_clone_app/feature/slide_action/slide_practice.dart';
import 'package:whatsapp_clone_app/init_dependencies.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkLogedIn(BuildContext context) async {
    final userToken = userTokenBox.get('userToken');

    print("User token: $userToken");

    if (userToken != null) {
      // Navigator.pushReplacementNamed(context, DashboardScreen.route);
      Navigator.pushReplacementNamed(context, SlidePractice.route);
    } else {
      // Navigator.pushReplacementNamed(context, PhoneNumberScreen.route);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkLogedIn(context);
      // Navigator.pushReplacementNamed(context, PhoneNumberScreen.route);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final height = MediaQuery.of(context).size.height;

    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 0.82 * height,
              width: double.infinity,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Constants.whatsappLogo,
                fit: BoxFit.cover,
                height: 76.h,
                color: isDarkMode ? kColorWhite : kColorPrimary,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 0.18 * height,
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "from",
                      style: kTextStyleHelveticaRegular400.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Constants.metaLogo,
                            fit: BoxFit.cover,
                            height: 16.h,
                            color: isDarkMode ? kColorWhite : kColorPrimary),
                        SizedBox(width: 4.h),
                        Text(
                          "Meta",
                          style: kTextStyleHelveticaRegular400.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w800,
                              color: isDarkMode ? kColorWhite : kColorPrimary),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
