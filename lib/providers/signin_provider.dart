import 'package:ecommerce_app/data/services/firebase_services.dart';
import 'package:ecommerce_app/screen/bottom_bar/bottom_bar.dart';
import 'package:ecommerce_app/widgets/custom_widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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

class ProductUpload with ChangeNotifier {
  bool isLoading = false;

  Future<void> uploadProduct(
    BuildContext context,
    VoidCallback addProduct,
  ) async {
    try {
      isLoading = true;
      addProduct();
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;
      notifyListeners();

      ToastMessage.toastSuccess(context, 'Product Uploaded Successfully');
      Navigator.pop(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: BottomBar(),
        ),
      );
    } catch (error) {
      print('Product is not Uploaded: $error');
    }
  }
}
