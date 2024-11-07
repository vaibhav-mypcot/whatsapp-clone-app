import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';

class PopmenubuttonWidget extends StatelessWidget {
  const PopmenubuttonWidget({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconColor: kColorWhite,
      color: isDarkMode ? kColorBlackBg : kColorWhite,
      shadowColor: kColorGreyBg,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'option1',
            child: Text(
              'New group',
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'option2',
            child: Text(
              'New broadcast',
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'option2',
            child: Text(
              'Linked devices',
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'option2',
            child: Text(
              'Starred message',
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'option2',
            child: Text(
              'Payments',
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'option2',
            child: Text(
              'Settings',
              style: kTextStyleHelveticaRegular400.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ];
      },
    );
  }
}
