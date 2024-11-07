import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';
import 'package:whatsapp_clone_app/core/theme/text_style.dart';
import 'package:whatsapp_clone_app/feature/contacts/presentation/page/contacts_list_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/dashboard_screen/presentation/widget/popmenubutton_widget.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/call/call_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chat_contact/presentation/pages/feed_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/status/status_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const String route = '/dashboard_screen';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController? tabController;
  int selectedIndex = 0;

  var uid = FirebaseAuth.instance.currentUser?.uid;

  void setUserState(bool isOnline) async {
    print("Method called : ${isOnline}");
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isOnline': isOnline,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        setUserState(false);
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    tabController?.addListener(_getActiveTabIndex);
    WidgetsBinding.instance.addObserver(this);
  }

  void _getActiveTabIndex() {
    setState(() {});
    selectedIndex = tabController!.index;
    debugPrint('CURRENT_PAGE ${selectedIndex.toString()}');
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? const Color(0xff1F2C34) : kColorPineGreen,
        title: Text(
          'WhatsApp',
          style: kTextStyleHelveticaRegular400.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: kColorWhite,
          ),
        ),
        actions: [
          Icon(
            Icons.camera_enhance_rounded,
            size: 20.h,
            color: kColorWhite,
          ),
          SizedBox(width: 16.h),
          Icon(
            Icons.search,
            size: 20.h,
            color: kColorWhite,
          ),
          //-- Side Menu
          PopmenubuttonWidget(isDarkMode: isDarkMode),
        ],
        bottom: TabBar(
          onTap: (tabIndex) {
            selectedIndex = tabIndex;
          },
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: WidgetStatePropertyAll(
            kColorWhite.withOpacity(0.1),
          ),
          tabs: [
            Tab(
              icon: Text(
                "Chats",
                style: kTextStyleHelveticaRegular400.copyWith(
                  fontSize: 12.sp,
                  color: kColorWhite,
                ),
              ),
            ),
            Tab(
              icon: Text(
                "Updates",
                style: kTextStyleHelveticaRegular400.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w200,
                  color: kColorWhite,
                ),
              ),
            ),
            Tab(
              icon: Text(
                "Calls",
                style: kTextStyleHelveticaRegular400.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w200,
                  color: kColorWhite,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          FeedScreen(),
          StatusScreen(),
          CallScreen(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'EditStatus',
            onPressed: () {
              Navigator.of(context).pushNamed(ContactsListScreen.route);
            },
            mini: false,
            backgroundColor: isDarkMode ? kColorPrimary : kColorPineGreen,
            child: Icon(
              Icons.edit,
              size: 20.h,
              color: isDarkMode ? kColorBlackBg : kColorWhiteBg,
            ),
          )
          // : const SizedBox.shrink(),
          // SizedBox(height: 12.h),
          // FloatingActionButton(
          //   heroTag: "FloatingButton1",
          //   onPressed: () {
          //     if (homeController.selectedIndex.toInt() == 0) {
          //       Get.toNamed(AppRoutes.selectContactScreen);
          //     } else if (homeController.selectedIndex.toInt() == 1) {
          //     } else if (homeController.selectedIndex.toInt() == 2) {}
          //   },
          //   backgroundColor: isDarkMode ? TColors.primary : TColors.pineGreen,
          //   child: homeController.selectedIndex.toInt() == 0
          //       ? RotatedBox(
          //           quarterTurns: 0,
          //           child: Icon(
          //             Icons.message,
          //             size: 24.h,
          //             color: isDarkMode ? TColors.blackBg : kColorWhiteBg,
          //           ),
          //         )
          //       : homeController.selectedIndex.toInt() == 1
          //           ? Icon(
          //               Icons.camera_alt,
          //               size: 24.h,
          //               color: isDarkMode ? TColors.blackBg : kColorWhiteBg,
          //             )
          //           : Icon(
          //               Icons.add_call,
          //               size: 24.h,
          //               color: isDarkMode ? TColors.blackBg : kColorWhiteBg,
          //             ),
          // ),
        ],
      ),
    );
  }
}
