import 'package:flutter/material.dart';
import 'package:i_smile_kids_app/core/utils/color_manger.dart';
import 'package:i_smile_kids_app/features/confrim_visit/presentation/views/confrim_your_visit_view.dart';
import 'package:i_smile_kids_app/features/dental_care_tips/presentation/views/dental_care_tips_view.dart';
import 'package:i_smile_kids_app/features/home/presentation/views/home_view.dart';
import 'package:i_smile_kids_app/features/profile/presentation/views/profile_view.dart';
import 'package:i_smile_kids_app/features/video_tips/presentation/views/videos_tips_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PersistentTabController _controller = PersistentTabController();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  @override
  void dispose() {
    _controller.dispose(); // مهم جداً!
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const DentalCareTipsView(),
      const VideosTipsView(),
      // ScanQrCodeView(),
      ConfirmYourVisitView(),
      const ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: ColorManager.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.tips_and_updates),
        title: ("Dental Tips"),
        activeColorPrimary: ColorManager.warning,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.ondemand_video_rounded),
        title: ("Videos Tips"),
        activeColorPrimary: ColorManager.textDark,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.qr_code_scanner),
        title: ("Scan Qr"),
        activeColorPrimary: ColorManager.secondary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      // popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      // itemAnimationProperties: const ItemAnimationProperties(
      //   duration: Duration(milliseconds: 200),
      //   curve: Curves.ease,
      // ),
      // screenTransitionAnimation: const ScreenTransitionAnimation(
      //   animateTabTransition: true,
      //   curve: Curves.ease,
      //   duration: Duration(milliseconds: 200),
      // ),
      navBarStyle: NavBarStyle.style9, // فيه ستايلات كتير جرّبهم
    );
  }
}
