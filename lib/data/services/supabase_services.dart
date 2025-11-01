import 'dart:io';
import 'package:ecommerce_app/data/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final supabase = Supabase.instance.client;
  final tablename = 'product';
  final imageTable = 'product_Images';

  Future<void> saveProduct({
    required String title,
    required String description,
    required String price,
    required List<File> images,
  }) async {
    try {
      List<String> imagesUrls = [];

      for (var image in images) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final originalName = image.path.split('/').last;
        final fileName = "${timestamp}_$originalName";

        await supabase.storage.from(imageTable).upload(fileName, image);

        final imageUrl = supabase.storage
            .from(imageTable)
            .getPublicUrl(fileName);

        imagesUrls.add(imageUrl);
      }

      final generateId = DateTime.now().millisecondsSinceEpoch;

      Product newProduct = Product(
        id: generateId,
        title: title,
        description: description,
        price: num.parse(price),
        images: imagesUrls,
      );

      final response = await supabase
          .from(tablename)
          .insert(newProduct.toJson());
      print("✅ Product uploaded successfully: $response");
    } catch (error) {
      print("❌ Error while saving product: $error");
      throw Exception('Error: $error');
    }
  }

  Stream<List<Product>> getProducts() {
    return supabase.from(tablename).stream(primaryKey: ['id']).map((data) {
      return data.map((row) => Product.fromJson(row)).toList();
    });
  }
}
