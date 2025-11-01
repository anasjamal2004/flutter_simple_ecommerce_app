import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNavigationBarUi {
  // Light Navigation Bar
  static const SystemUiOverlayStyle lightbar = SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
