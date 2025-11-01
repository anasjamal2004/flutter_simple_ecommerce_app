import 'package:ecommerce_app/providers/signin_provider.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/view/constants/images.dart';
import 'package:ecommerce_app/view/constants/navigation_bar.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({super.key});

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  @override
  Widget build(BuildContext context) {
    //
    SystemChrome.setSystemUIOverlayStyle(AppNavigationBarUi.lightbar);
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Shopnest', color: AppColor.blackColor),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColor.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: AppImages().onlineStoreImage,
          ),
          const SizedBox(height: 140),
          const CustomText(
            text: "Let's Explore Shopnest",
            color: AppColor.blackColor,
            fontSize: 25,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 25),
            child: Consumer<SigninProvider>(
              builder: (context, value, child) {
                return CustomButton(
                  loadingColor: AppColor.whiteColor,
                  isLoading: value.isLoading,
                  width: double.infinity,
                  text: 'Sign in with Google',
                  onTap: () {
                    value.loadingFunction(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
