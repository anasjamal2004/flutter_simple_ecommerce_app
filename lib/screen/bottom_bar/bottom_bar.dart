import 'package:ecommerce_app/screen/favourite/favourite.dart';
import 'package:ecommerce_app/screen/home/home.dart';
import 'package:ecommerce_app/screen/settings/settings.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/view/constants/navigation_bar.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  final List<Widget> pages = [Home(), Favourite(), Settings()];

  //
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppNavigationBarUi.lightbar);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const CustomText(text: 'Shopnest', color: AppColor.blackColor),
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: AppColor.whiteColor,
      body: IndexedStack(index: currentIndex, children: pages),
      // Navigation Bar
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.premiumblackColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: GNav(
            backgroundColor: AppColor.premiumblackColor,
            color: Colors.grey,
            activeColor: AppColor.blackColor,
            tabBackgroundColor: AppColor.greenColor,
            tabBorderRadius: 25,
            gap: 2,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.favorite_border_outlined, text: 'Favourite'),
              GButton(icon: Icons.settings_outlined, text: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
