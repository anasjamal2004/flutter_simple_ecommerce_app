import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/model/product_model.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/screen/home/product_details.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  final List<Product>? allProducts;
  const Favourite({this.allProducts, super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FavouriteProvider>().getFavouritesProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavouriteProvider>();
    return ListView.builder(
      itemCount: provider.favouriteProduct.length,
      itemBuilder: (context, index) {
        final product = provider.favouriteProduct[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            elevation: 4,
            child: OpenContainer(
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: const Duration(milliseconds: 300),
              closedElevation: 4,
              closedColor: Colors.white,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              openBuilder: (context, _) => ProductDetails(product: product),
              closedBuilder: (context, openContainer) {
                return GestureDetector(
                  onTap: openContainer,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: product.images[0],
                        height: 170,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(
                          Icons.broken_image,
                          size: 170,
                          color: Colors.grey,
                        ),
                      ),
                      title: CustomText(
                        text: product.title,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: CustomText(
                        text: '\$${product.price.toString()}',
                        color: AppColor.blackColor,
                      ),
                      trailing: Consumer<FavouriteProvider>(
                        builder: (context, provider, child) {
                          final isFavourite = provider.containsFavouriteProduct(
                            product,
                          );
                          return FavouriteButton(
                            isFavourite: isFavourite,
                            onTap: () {
                              context
                                  .read<FavouriteProvider>()
                                  .toggleFavouriteFunction(product);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
