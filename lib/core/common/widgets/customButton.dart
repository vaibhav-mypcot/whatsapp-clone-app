import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.isDarkMode,
    this.radius,
    this.onTap,
  });

  final String label;
  final bool isDarkMode;
  final double? radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 32.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kColorPineGreen,
          borderRadius: BorderRadius.circular(radius ?? 18.r),
        ),
        child: Text(
          label.toString(),
          style: kTextStyleHelveticaRegular400.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? kColorBlackBg : kColorWhite,
          ),
        ),
      ),
    );
  }
}
