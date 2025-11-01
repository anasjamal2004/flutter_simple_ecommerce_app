import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/providers/signin_provider.dart';
import 'package:ecommerce_app/screen/start_screen/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://lzmdjfkzsyrfqqztfwew.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx6bWRqZmt6c3lyZnFxenRmd2V3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkyNDkwNzgsImV4cCI6MjA3NDgyNTA3OH0.1ewgKVXRPOC9-hM5VIV3fa1Yih2yJPAaQiPKIoQd0Yk',
  );
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //SystemChrome.setSystemUIOverlayStyle(AppNavigationBarUi.lightbar);
  // debugPrintRebuildDirtyWidgets = true;
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SigninProvider()),
        ChangeNotifierProvider(create: (_) => ProductUpload()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: GetStarted()),
    );
  }
}
