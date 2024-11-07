import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/common/widgets/customButton.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/page/setup_profile_screen.dart';

class VerifyNumberScreen extends StatelessWidget {
  VerifyNumberScreen({
    super.key,
    required this.verificationId,
  });

  static const String route = '/verify_number_screen';
  static PhoneAuthCredential? globalCredential;

  final String verificationId;
  final otpVerificationController = TextEditingController();
  // PhoneAuthCredential? globalCredential;
  

  // Bottom Sheet

  void showModelBottomSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? kColorBlackBg : kColorWhite,
      builder: (context) {
        return Container(
          height: 320.h,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 16.h),
                alignment: Alignment.topLeft,
                child: const Icon(Icons.close),
              ),
              const CircleAvatar(
                radius: 28,
                backgroundColor: kColorPrimary,
                child: Icon(
                  Icons.message,
                  color: kColorWhite,
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        "Didn't receive a verification code?",
                        textAlign: TextAlign.center,
                        style: kTextStyleHelveticaRegular400.copyWith(
                          fontSize: 21.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Please check your SMS message before requesting another code.",
                        textAlign: TextAlign.center,
                        style: kTextStyleHelveticaRegular400.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 36.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.messenger,
                      color: Colors.grey,
                      size: 16.h,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Resend SMS',
                      style: kTextStyleHelveticaLight300.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 36.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.8,
                    )),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call,
                      color: kColorPrimary,
                      size: 16.h,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Call me',
                      style: kTextStyleHelveticaLight300.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: kColorPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Verifying your number',
          style: kTextStyleHelveticaLight300.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? kColorWhite : kColorPineGreen,
          ),
        ),
        actions: [
          PopupMenuButton(
            color: isDarkMode ? kColorBlackBg : kColorWhite,
            shadowColor: kColorGreyBg,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'option1',
                  child: Text(
                    'Link as companion device',
                    style: kTextStyleHelveticaRegular400.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'option2',
                  child: Text(
                    'Help',
                    style: kTextStyleHelveticaRegular400.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.h),
        child: Column(
          children: [
            Text.rich(
              TextSpan(
                text: "Waiting to automatically detect an SMS sent to ",
                style: kTextStyleHelveticaRegular400.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w200,
                ),
                children: [
                  TextSpan(
                    text: "+91 96544 44533. ",
                    style: kTextStyleHelveticaRegular400.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ), // Change the color of this text
                  ),
                  const TextSpan(
                    text: "Wrong number?",
                    style: TextStyle(
                        color: Colors.blue), // Change the color of this text
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Container(
              width: 100.w,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: TextFormField(
                      cursorColor: kColorPrimary,
                      keyboardType: TextInputType.number,
                      controller: otpVerificationController,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                      decoration: InputDecoration(
                        hintText: "– – –   – – –",
                        hintStyle: kTextStyleHelveticaRegular400.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                      style: kTextStyleHelveticaRegular400.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const Divider(
                    color: kColorPrimary,
                    height: 1.8,
                    thickness: 1.6,
                  )
                ],
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'Enter 6-digit code',
              textAlign: TextAlign.center,
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => showModelBottomSheet(context, isDarkMode),
              child: Text(
                "Didn't recive code?",
                textAlign: TextAlign.center,
                style: kTextStyleHelveticaRegular400.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'You may request a new code in 0:49',
              textAlign: TextAlign.center,
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Container(
                width: 60.w,
                padding: EdgeInsets.only(bottom: 20.h),
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    try {
                      globalCredential = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpVerificationController.text);

                      await FirebaseAuth.instance.signInWithCredential(globalCredential!);
                      Navigator.pushNamed(context, SetupProfileScreen.route);
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: CustomButton(
                    label: "Next",
                    isDarkMode: isDarkMode,
                    radius: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
