import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/data/model/product_model.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_cachedimage.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final Product? product;
  final List<Product>? allProducts;
  const ProductDetails({this.product, this.allProducts, super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: CustomButton(
          width: double.infinity,
          text: 'Add to Cart',
          onTap: () {},
        ),
      ),
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const CustomText(
          text: 'Product Details',
          color: AppColor.blackColor,
        ),
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.lightGreyColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Consumer<ProductDetailProvider>(
                  builder: (context, provider, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomCachedimage(
                        imageUrl: product!.images[provider.currentIndex],
                        placeHolderWidget: Center(
                          child: CircularProgressIndicator(),
                        ),
                        memCacheHeight: 800,
                        height: 0,
                        errorWidget: const Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey,
                        ),
                        valueKey: ValueKey(
                          product.images[provider.currentIndex],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 80,
              child: Align(
                alignment: AlignmentGeometry.topCenter,
                child: Consumer<ProductDetailProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: product!.images.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<ProductDetailProvider>().changeIndex(
                              index,
                            );
                          },
                          child: Container(
                            width: 80,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: provider.currentIndex == index
                                    ? AppColor.greenColor
                                    : Colors.grey,

                                width: 3,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: CachedNetworkImage(
                                imageUrl: product.images[index],
                                key: ValueKey(product.images[index]),
                                memCacheHeight: 300,
                                fadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                placeholderFadeInDuration: Duration.zero,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            // Product Details in Text
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: product!.title.toString(),
                          color: AppColor.blackColor,
                          fontSize: 25,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Consumer<FavouriteProvider>(
                        builder: (context, provider, child) {
                          final isFavourite = provider.containsFavouriteProduct(
                            widget.product!,
                          );
                          return FavouriteButton(
                            isFavourite: isFavourite,
                            onTap: () {
                              context
                                  .read<FavouriteProvider>()
                                  .toggleFavouriteFunction(widget.product!);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  CustomText(
                    text: '\$${product.price.toString()}',
                    color: AppColor.blackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    text: product.description.toString(),
                    color: AppColor.blackColor,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
