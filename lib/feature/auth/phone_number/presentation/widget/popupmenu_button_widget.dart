import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';

class PopupmenuButtonWidget extends StatelessWidget {
  const PopupmenuButtonWidget({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
    );
  }
}
