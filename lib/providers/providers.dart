import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/providers/signin_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => ProductProvider()..fetchProduct(),
      lazy: false,
    ),
    ChangeNotifierProvider(create: (_) => SigninProvider()),
    ChangeNotifierProvider(create: (_) => ProductUpload()),
    ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
    ChangeNotifierProvider(create: (_) => FavouriteProvider()),
  ];
}
