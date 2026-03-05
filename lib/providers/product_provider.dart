import 'dart:async';
import 'package:ecommerce_app/data/model/product_model.dart';
import 'package:ecommerce_app/data/services/supabase_services.dart';
import 'package:ecommerce_app/view/shared_Peference/shared_services.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _product = [];
  bool _isLoading = false;

  List<Product> get products => _product;
  bool get isLoading => _isLoading;

  StreamSubscription<List<Product>>? _subscription;

  Future<void> fetchProduct() async {
    if (_product.isNotEmpty || _subscription != null) {
      return;
    } else {
      Future.microtask(() {
        _isLoading = true;
        notifyListeners();
      });

      _subscription = SupabaseServices().getProducts().listen((data) {
        _product = data;
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

class ProductDetailProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class FavouriteProvider with ChangeNotifier {
  bool _isFavourite = false;
  List<Product> _favouriteProduct = [];
  bool get isFavourite => _isFavourite;
  List<Product> get favouriteProduct => _favouriteProduct;

  Future<void> toggleFavouriteFunction(Product product) async {
    if (_favouriteProduct.any((p) => p.id == product.id)) {
      _favouriteProduct.removeWhere((p) => p.id == product.id);
    } else {
      _favouriteProduct.add(product);
    }
    await SharedPeferencesServices.saveFavourites(_favouriteProduct);
    notifyListeners();
  }

  bool containsFavouriteProduct(Product product) {
    return _favouriteProduct.any((p) => p.id == product.id);
  }

  Future<void> getFavouritesProducts() async {
    _favouriteProduct = await SharedPeferencesServices.getFavourites();
    notifyListeners();
  }
}
