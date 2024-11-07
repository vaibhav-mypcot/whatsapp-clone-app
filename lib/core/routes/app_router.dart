import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/page/phone_number_screen.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/feature/contacts/presentation/page/contacts_list_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/dashboard_screen/presentation/page/dashboard_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/pages/chat_screen.dart';
import 'package:whatsapp_clone_app/feature/onboarding/onboarding_screen.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/page/setup_profile_screen.dart';
import 'package:whatsapp_clone_app/feature/slide_action/slide_practice.dart';
import 'package:whatsapp_clone_app/feature/splash/splash_screen.dart';

class AppRoute {
  const AppRoute._();

  static const String splash = '/';

  // we use onGenerateRoute with CupertinoPageRoute objects to get specific page transition animations
  // (sliding in from the right if there's a back button, sliding from the bottom up if there's a close button)
  // it is preferable to use Navigator.pushNamed (rather than Navigator.push) for large projects
  // cf. CupertinoPageRoute documentation -> fullscreenDialog: true, (in this case the page slides in from the bottom)
  static Route<void> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments != null
        ? settings.arguments as Map<String, dynamic>
        : <String, dynamic>{};
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case DashboardScreen.route:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case OnboardingScreen.route:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case PhoneNumberScreen.route:
        return _createSlideTransition(const PhoneNumberScreen(), "right");
      // Creating workspace routes
      case VerifyNumberScreen.route:
        return _createSlideTransition(
            VerifyNumberScreen(verificationId: arguments['verificationId']),
            "right");
      case SetupProfileScreen.route:
        return _createSlideTransition(SetupProfileScreen(), "right");
      case ContactsListScreen.route:
        return _createSlideTransition(const ContactsListScreen(), "right");
      case SlidePractice.route:
        return _createSlideTransition(const SlidePractice(), "right");
      case ChatScreen.route:
        return _createSlideTransition(
          ChatScreen(
            reciverUserId: arguments['receiverId'],
            name: arguments['name'],
            imageUrl: arguments['imageUrl'],
          ),
          "right",
        );
      default:
        throw Exception(
            'no builder specified for route named: [${settings.name}]');
    }
  }

  static PageRouteBuilder _createSlideTransition(Widget page, String position) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset.zero;
        switch (position) {
          case "right":
            begin = const Offset(1.0, 0.0); // Start from right (slide-in)
          case "left":
            begin = const Offset(-1.0, 0.0); // Start from left (slide-in)
          case "top":
            begin = const Offset(0.0, -1.0); // Start from top (slide-in)
          case "bottom":
            begin = const Offset(0.0, 1.0); // Start from bottom (slide-in)
          default:
            begin = const Offset(1.0, 0.0); // Start from right (slide-in)
        }

        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
