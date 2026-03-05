import 'package:ecommerce_app/data/services/firebase_services.dart';
import 'package:ecommerce_app/screen/bottom_bar/bottom_bar.dart';
import 'package:ecommerce_app/widgets/custom_widgets/toast_message.dart';
import 'package:flutter/material.dart';

class SigninProvider with ChangeNotifier {
  bool isLoading = false;

  Future<void> loadingFunction(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final firebaseServices = FirebaseServices();
      final user = await firebaseServices.continueWithGoogle();
      await Future.delayed(const Duration(seconds: 2));
      if (user != null) {
        isLoading = false;
        notifyListeners();

        ToastMessage.toastSuccess(
          context,
          'Successfully signin to Google account',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomBar()),
        );
      } else {
        isLoading = false;
        notifyListeners();
        ToastMessage.toastError(context, 'Failed to signin');
      }
    } catch (error) {
      ToastMessage.toastError(context, 'Failed to signin');
      isLoading = false;
      notifyListeners();
    }
  }
}
