import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_app/data/model/product_model.dart';

class SharedPeferencesServices {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String favourite = 'favourite';
  static const String checking = 'Get Started';

  // Add Favourite
  static Future<void> saveFavourites(List<Product> favouriteProduct) async {
    List<String> productsJson = favouriteProduct
        .map((p) => jsonEncode(p.toJson()))
        .toList();
    await _prefs.setStringList(favourite, productsJson);
  }

  static Future<List<Product>> getFavourites() async {
    List<String> productsJson = _prefs.getStringList(favourite) ?? [];
    return productsJson
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();
  }

  // GetStarted Screen -> One time save.

  static Future<void> setScreen(bool value) async {
    await _prefs.setBool(checking, value);
  }

  static bool get getScreen {
    return _prefs.getBool(checking) ?? false;
  }
}
