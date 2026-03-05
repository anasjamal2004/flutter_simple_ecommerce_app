import 'package:ecommerce_app/screen/bottom_bar/bottom_bar.dart';
import 'package:ecommerce_app/screen/start_screen/get_started.dart';
import 'package:ecommerce_app/screen/start_screen/google_sign_in.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/view/constants/images.dart';
import 'package:ecommerce_app/view/constants/navigation_bar.dart';
import 'package:ecommerce_app/view/shared_Peference/shared_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _screenStatus();
  }

  void _screenStatus() async {
    bool status = SharedPeferencesServices.getScreen;
    final user = FirebaseAuth.instance.currentUser;

    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );
    } else if (status == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GoogleSignInPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppNavigationBarUi.lightbar);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(child: AppImages.appIcon),
    );
  }
}
