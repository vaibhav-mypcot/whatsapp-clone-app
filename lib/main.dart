import 'dart:math';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_app/contact_list.dart';
import 'package:whatsapp_clone_app/core/routes/app_router.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/bloc/phone_number_bloc.dart';
import 'package:whatsapp_clone_app/feature/auth/verify_number/verify_number_screen.dart';
import 'package:whatsapp_clone_app/feature/contacts/presentation/bloc/contact_list_bloc.dart';
import 'package:whatsapp_clone_app/feature/contacts/presentation/page/contacts_list_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/dashboard_screen/presentation/page/dashboard_screen.dart';
import 'package:whatsapp_clone_app/feature/dashboard/pages/chats/presentation/bloc/chat_bloc.dart';
import 'package:whatsapp_clone_app/feature/onboarding/onboarding_screen.dart';
import 'package:whatsapp_clone_app/feature/auth/phone_number/presentation/page/phone_number_screen.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/bloc/profile_setup_bloc.dart';
import 'package:whatsapp_clone_app/feature/profile_setup/presentation/page/setup_profile_screen.dart';
import 'package:whatsapp_clone_app/feature/splash/splash_screen.dart';
import 'package:whatsapp_clone_app/firebase_options.dart';
import 'package:whatsapp_clone_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize App Check with Play Integrity on Android
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ContactListBloc>(
          create: (_) => serviceLocator<ContactListBloc>(),
        ),
        BlocProvider<PhoneNumberBloc>(
          create: (_) => serviceLocator<PhoneNumberBloc>(),
        ),
        BlocProvider<ProfileSetupBloc>(
          create: (_) => serviceLocator<ProfileSetupBloc>(),
        ),
        BlocProvider<ChatBloc>(
          create: (_) => serviceLocator<ChatBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        initialRoute: SplashScreen.route,
        onGenerateRoute: AppRoute.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        // home: const ContactsPage(),
      ),
    );
  }
}
