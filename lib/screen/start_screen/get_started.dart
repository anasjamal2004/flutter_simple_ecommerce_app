import 'package:ecommerce_app/screen/start_screen/google_sign_in.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/view/constants/images.dart';
import 'package:ecommerce_app/view/constants/navigation_bar.dart';
import 'package:ecommerce_app/view/shared_Peference/shared_services.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final bool setScreen = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppNavigationBarUi.lightbar);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Shopnest', color: AppColor.blackColor),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColor.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 450,
            width: double.infinity,
            child: AppImages.getStartedImage,
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CustomText(
              text: 'New Fashion Collection',
              color: AppColor.blackColor,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: CustomText(
              text: 'Shop Smarter, Faster with ShopNest',
              color: AppColor.blackColor,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 15),
          Align(
            alignment: AlignmentGeometry.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomButton(
                width: double.infinity,
                text: 'Get Started',
                onTap: () async {
                  await SharedPeferencesServices.setScreen(setScreen);

                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        child: GoogleSignInPage(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
