import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';

class FeedTile extends StatelessWidget {
  const FeedTile({
    super.key,
    required this.profilePic,
    required this.name,
    this.date,
    required this.status,
  });

  final String profilePic;
  final String name;
  final String status;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundImage: FadeInImage(
            height: 100.h,
            width: 100.w,
            image: NetworkImage(profilePic),
            placeholder: const AssetImage(Constants.profileImage),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                Constants.profileImage,
                fit: BoxFit.cover,
                height: 100.h,
                width: 100.w,
              );
            },
            fit: BoxFit.cover,
            placeholderFit: BoxFit.scaleDown,
          ).image,
        ),
        // Title
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name.toString(),
                      style: kTextStyleHelveticaRegular400.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    date == null
                        ? SizedBox.shrink()
                        : Text(
                            date.toString(),
                            style: kTextStyleHelveticaRegular400.copyWith(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                  ],
                ),
                Text(
                  status.toString(),
                  textAlign: TextAlign.left,
                  style: kTextStyleHelveticaRegular400.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
