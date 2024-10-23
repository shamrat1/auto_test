import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:auto_ichi/controllers/bookings_controller.dart';
import 'package:auto_ichi/screens/calendar_screen.dart';
import 'package:auto_ichi/screens/dashboard_screen.dart';
import 'package:auto_ichi/screens/profile_screen.dart';
import 'package:auto_ichi/screens/signin_screen.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:auto_ichi/utils/constants/sizes.dart';
import 'package:auto_ichi/utils/storage/shared_prefs.dart';
import 'package:auto_ichi/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await SharedPrefs.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 801),
      splitScreenMode: false,
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dokan',
          theme: TAppTheme.lightTheme,
          home: HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final AuthenticationController _controller =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.authenticated.value) {
        return const LandingPage();
      }
      return const SigninScreen();
    });
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final BookingsController _bookingsController = Get.put(BookingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      const Color(0xffFF7B51),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: TSizes.iconMd,
                ),
              ),
            )
          : null,
      body: PageView(
        controller: _pageController,
        onPageChanged: (val) => setState(() {
          _currentPage = val;
        }),
        children: [
          const DashboardScreen(),
          CalendarScreen(),
          CalendarScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: TSizes.iconMd,
        icons: const [
          Icons.dashboard_rounded,
          Icons.calendar_month,
          Icons.calendar_today,
          Icons.person,
        ],
        activeIndex: _currentPage,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeColor: TColors.primary,
        inactiveColor: TColors.darkGrey,
        onTap: (index) {
          setState(() {
            _currentPage = index;
            if (index == 1) {
              _bookingsController.setView(CalendarView.month);
            }
            if (index == 2) {
              _bookingsController.setView(CalendarView.day);
            }
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}
