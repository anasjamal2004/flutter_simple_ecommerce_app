import 'package:ecommerce_app/screen/bottom_bar/bottom_bar.dart';
import 'package:ecommerce_app/widgets/custom_widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ProductUpload with ChangeNotifier {
  bool isLoading = false;

  Future<void> uploadProduct(
    BuildContext context,
    Future<bool> Function() addroduct,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      bool isSuccess = await addroduct();

      if (isSuccess == true) {
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
      } else {
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print('Product is not Uploaded: $error');
    }
  }
}
