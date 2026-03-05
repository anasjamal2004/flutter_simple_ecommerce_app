import 'package:ecommerce_app/animation/animation.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Normal Buttons
class CustomButton extends StatelessWidget {
  final Color loadingColor;
  final double? width;
  final String? text;
  final GestureTapCallback onTap;
  final bool isLoading;
  const CustomButton({
    required this.width,
    required this.text,
    required this.onTap,
    this.loadingColor = Colors.transparent,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: isLoading
              ? LoadingAnimation(loadingColor: loadingColor)
              : Text(
                  text!,
                  style: GoogleFonts.poppins(color: AppColor.blackColor),
                ),
        ),
      ),
    );
  }
}

class CustomRoundButton extends StatelessWidget {
  final GestureTapCallback onTap;
  const CustomRoundButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: AppColor.greenColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

class FavouriteButton extends StatelessWidget {
  final bool isFavourite;
  final GestureTapCallback onTap;
  const FavouriteButton({
    required this.isFavourite,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        size: 35,
        isFavourite ? Icons.favorite : Icons.favorite_border_outlined,
        color: isFavourite ? AppColor.greenColor : AppColor.blackColor,
      ),
    );
  }
}

class CustomGeneralButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final Color textColor;
  final IconData leadingIcon;
  final IconData tralingIcon;
  final Color leadingIconColor;
  const CustomGeneralButton({
    required this.text,
    required this.textColor,
    required this.leadingIcon,
    required this.tralingIcon,
    required this.onTap,
    required this.leadingIconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.lightGreyColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: leadingIconColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(leadingIcon, color: AppColor.whiteColor),
                  ),
                  SizedBox(width: 10),
                  CustomText(
                    text: text,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ],
              ),
              Icon(tralingIcon),
            ],
          ),
        ),
      ),
    );
  }
}
