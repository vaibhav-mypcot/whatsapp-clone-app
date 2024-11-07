import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone_app/core/common/widgets/language_list_tile.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/page/phone_number_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  static const String route = '/onboarding_screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            AnimatedOpacity(
              //opacity: onBoardingController.isClicked.value ? 1.0 : 0.5,
              opacity: 0.5,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 64.h),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Constants.welcomeLogo,
                      fit: BoxFit.cover,
                      height: 280.h,
                    ),
                  ],
                ),
              ),
            ),

            // Welcome msg with language list
            AnimatedOpacity(
              //opacity: onBoardingController.isClicked.value ? 0.0 : 1.0,
              opacity: 1.0,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: isDarkMode
                      ? kDarkGradientBackgroundColor
                      : kLightGradientBackgroundColor,
                ),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(height: 184.h),
                    Text(
                      "Welcome to WhatsApp",
                      style: kTextStyleHelveticaRegular400.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Choose your language to get started",
                      style: kTextStyleHelveticaRegular400.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: LanguageListTile.languagesList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return LanguageListTile(
                            index: index,
                            selectedIndex: selectedIndex,
                            onSelectedIndexChanged: setSelectedIndex,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // AnimatedOpacity(
            //   //opacity: onBoardingController.isClicked.value ? 1.0 : 0.0,
            //   opacity: 0.0,
            //   duration: Duration(milliseconds: 500),
            //   curve: Curves.easeInOut,
            //   child: Container(
            //     margin: EdgeInsets.only(top: 68.h),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SizedBox(height: 52.h),
            //         Text(
            //           "Welcome to WhatsApp",
            //           style: kTextStyleHelveticaRegular400.copyWith(
            //             fontSize: 22.sp,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         SizedBox(height: 12.h),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 20.w),
            //           child: Text(
            //             'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Services.',
            //             textAlign: TextAlign.center,
            //             style: kTextStyleHelveticaRegular400.copyWith(
            //               fontSize: 12.sp,
            //               fontWeight: FontWeight.w300,
            //               color: kColorGreyBg,
            //             ),
            //           ),
            //         ),
            //         SizedBox(height: 18.h),
            //         GestureDetector(
            //           onTap: () {
            //             showModalBottomSheet(
            //               isScrollControlled: true,
            //               isDismissible: true,
            //               context: context,
            //               backgroundColor: Colors.transparent,
            //               builder: (context) => ExpandableBottomSheet(
            //                 isDarkMode: isDarkMode,
            //               ),
            //             );
            //           },
            //           child: Container(
            //             padding: EdgeInsets.symmetric(vertical: 8.h),
            //             decoration: BoxDecoration(
            //                 color: kColorPrimary.withOpacity(0.1),
            //                 borderRadius: BorderRadius.circular(24.r)),
            //             width: 124.h,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   Icons.language,
            //                   size: 20.h,
            //                   color: kColorPrimary,
            //                 ),
            //                 SizedBox(width: 8.w),
            //                 Text(
            //                   'English',
            //                   style: kTextStyleHelveticaRegular400.copyWith(
            //                     fontSize: 12.sp,
            //                     fontWeight: FontWeight.w400,
            //                     color: kColorPrimary.withOpacity(0.8),
            //                   ),
            //                 ),
            //                 SizedBox(width: 8.w),
            //                 RotatedBox(
            //                   quarterTurns: 1,
            //                   child: Icon(
            //                     Icons.chevron_right,
            //                     size: 20.h,
            //                     color: kColorPrimary,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            // Next Button
            AnimatedOpacity(
              //opacity: onBoardingController.isClicked.value ? 0.0 : 1.0,
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PhoneNumberScreen.route);
                },
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(right: 20.h, bottom: 20.h),
                  child: Container(
                    height: 54.h,
                    width: 54.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kColorPineGreen,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        isDarkMode
                            ? const BoxShadow()
                            : const BoxShadow(
                                color: kColorLightGray,
                                blurRadius: 4,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(0, 4),
                              ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: isDarkMode ? kColorBlackBg : kColorWhiteBg,
                      size: 24.h,
                    ),
                  ),
                ),
              ),
            ),

            // Agree and continue
            // AnimatedOpacity(
            //   //opacity: onBoardingController.isClicked.value ? 1.0 : 0.0,
            //   opacity: 0.0,
            //   duration: const Duration(milliseconds: 500),
            //   child: GestureDetector(
            //     // onTap: () => Get.toNamed(AppRoutes.phoneNumberScreen),
            //     child: Container(
            //       alignment: Alignment.bottomRight,
            //       padding:
            //           EdgeInsets.only(right: 20.w, left: 20.w, bottom: 20.h),
            //       child: Container(
            //         height: 32.h,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           color: kColorPineGreen,
            //           borderRadius: BorderRadius.circular(14.r),
            //         ),
            //         child: Text(
            //           'Agree and continue',
            //           style: kTextStyleHelveticaRegular400.copyWith(
            //             fontSize: 12.sp,
            //             fontWeight: FontWeight.w500,
            //             color: isDarkMode ? kColorBlackBg : kColorWhiteBg,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
