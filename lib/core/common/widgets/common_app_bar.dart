import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/common/widgets/loader_widget.dart';
import 'package:whatsapp_clone_app/core/constants/constants.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/message_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/data/model/user_model.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/pages/chat_screen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonAppBar({
    super.key,
    required this.title,
    required this.getBack,
    this.profilePics,
    required this.icons,
    this.onClick,
  });

  final String title;
  final VoidCallback getBack;
  final String? profilePics;
  final List<IconData> icons;
  final VoidCallback? onClick;
  // final bool isOnline;

  var uid = FirebaseAuth.instance.currentUser?.uid;

  Stream<UserModel> userData(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode
          ? const Color(0xff1F2C34)
          : kColorPineGreen, // Change this color to the desired color
    ));
    return Container(
      color: isDarkMode ? const Color(0xff1F2C34) : kColorPineGreen,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 25 / 3,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.red,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: getBack,
                        child: Container(
                          // color: Colors.red,
                          width: 36.h,
                          height: 44.h,
                          child: Center(
                              child: Icon(
                            Icons.arrow_back,
                            size: 18.h,
                            color: kColorWhite,
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: onClick,
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.amber,
                              child: profilePics == null
                                  ? SizedBox.shrink()
                                  : CircleAvatar(
                                      radius: 24.r,
                                      backgroundImage: FadeInImage(
                                        height: 100.h,
                                        width: 100.w,
                                        image: NetworkImage(profilePics!),
                                        placeholder: const AssetImage(
                                            Constants.profileImage),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
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
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              // color: Colors.amberAccent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style:
                                        kTextStyleHelveticaRegular400.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: kColorWhite,
                                    ),
                                  ),
                                  StreamBuilder<UserModel>(
                                    stream: userData(uid!),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                          'online',
                                          style: TextStyle(
                                            fontSize: 12.h,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        );
                                      }
                                      return Text(
                                        snapshot.data!.isOnline
                                            ? 'online'
                                            : 'offline',
                                        style: TextStyle(
                                          fontSize: 12.h,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 120.w,
                height: 30.h,
                // color: Colors.blueAccent,
                // padding: EdgeInsets.only(right: 10.w),
                alignment: Alignment.bottomRight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: icons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        icons[index],
                        size: 24.h,
                        color: kColorWhite,
                      ),
                    );
                  },
                ),
              ),
              PopupMenuButton(
                iconColor: kColorWhite,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    child: Text('Item 1'),
                    value: 'item1',
                  ),
                  const PopupMenuItem(
                    child: Text('Item 2'),
                    value: 'item2',
                  ),
                  const PopupMenuItem(
                    child: Text('Item 3'),
                    value: 'item3',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(
        double.infinity,
        56.h,
      );
}
