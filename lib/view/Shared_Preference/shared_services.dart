import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/data/model/product_model.dart';

class SharedPeferencesServices {
  static const String favourite = 'favourite';

  static Future<void> saveFavourites(List<Product> favouriteProduct) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productsJson = favouriteProduct
        .map((p) => jsonEncode(p.toJson()))
        .toList();
    await prefs.setStringList(favourite, productsJson);
  }

  static Future<List<Product>> getFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productsJson = prefs.getStringList(favourite) ?? [];
    return productsJson
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();
  }
}
