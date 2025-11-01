class Product {
  final int? id;
  final String title;
  final String description;
  final num price;
  final List<String> images;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
  });

  // fromJson (Supabase ya API se data lene ke liye)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
    );
  }

  // toJson (Supabase me data bhejne ke liye)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'images': images,
    };
  }
}
