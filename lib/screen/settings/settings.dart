import 'package:ecommerce_app/data/services/firebase_services.dart';
import 'package:ecommerce_app/screen/start_screen/google_sign_in.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:ecommerce_app/widgets/custom_widgets/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  User? user;

  void getUserGoogleData() {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserGoogleData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: 110,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user!.photoURL!),
                  ),
                  Expanded(
                    child: ListTile(
                      title: CustomText(
                        text: user!.displayName.toString(),
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: CustomText(
                        text: user!.email.toString(),
                        color: AppColor.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: AlignmentGeometry.topLeft,
            child: CustomText(
              text: 'General',
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          // General Button
          CustomGeneralButton(
            text: 'Logout',
            textColor: AppColor.redColor,
            leadingIcon: Icons.logout,
            tralingIcon: Icons.keyboard_arrow_right_sharp,
            leadingIconColor: AppColor.redColor,
            onTap: () async {
              // logout logic
              await FirebaseServices().signOut().then((value) {
                ToastMessage.toastSuccess(context, 'Successfully signout');
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRight,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: GoogleSignInPage(),
                  ),
                  (route) => false,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
