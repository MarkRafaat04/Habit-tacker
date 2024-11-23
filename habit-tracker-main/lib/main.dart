import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/helpers/app_bloc_observer.dart';
import 'package:habit_tracker/core/helpers/hive_helper.dart';
import 'package:habit_tracker/core/helpers/locator.dart';
import 'package:habit_tracker/core/utils/constants.dart';
import 'package:habit_tracker/core/utils/text_styles.dart';
import 'package:habit_tracker/features/splash/view/splash_screen.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification channel for scheduled notifications',
        ledColor: Colors.white,
        importance: NotificationImportance.High,
      )
    ],
  );
  Bloc.observer = AppBlocObserver();
  await HiveHelper.init();
  setupLocator();
  runApp(const ToastificationWrapper(child: HabitTracker()));
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        navigatorKey: _navigator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: kOnPrimaryColor,
            ),
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kBackgroundColor,
            appBarTheme: const AppBarTheme(titleTextStyle: TextStyles.h1),
            textTheme: GoogleFonts.cairoTextTheme(),
            colorScheme: const ColorScheme.light().copyWith(
                primary: kPrimaryColor,
                secondary: kSecondaryColor,
                onPrimary: kOnPrimaryColor,
                onSecondary: kOnSecondaryColor,
                error: kErrorColor)),
        home: const SplashScreen(),
      ),
    );
  }
}

var _navigator = GlobalKey<NavigatorState>();

// Global Context
BuildContext get context => _navigator.currentContext!;
