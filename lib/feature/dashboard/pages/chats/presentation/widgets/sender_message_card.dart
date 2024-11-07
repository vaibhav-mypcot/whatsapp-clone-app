import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/common/enum/message_enum.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/widgets/display_text_image_gif.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.isDark,
    required this.type,
  }) : super(key: key);
  final String message;
  final String date;
  final bool isDark;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: isDark ? kColorGreyBg : const Color(0xffE7ffdb),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == MessageEnum.text
                    ? EdgeInsets.only(
                        left: 10.w,
                        right: 30.w,
                        top: 5.h,
                        bottom: 20.h,
                      )
                    : EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                        top: 5.h,
                        bottom: 25.h,
                      ),
                child: DisplayTextImageGIF(
                  message: message,
                  type: type,
                ),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? kColorWhite : kColorBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
