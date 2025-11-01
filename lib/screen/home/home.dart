import 'dart:async';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/animation/animation.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/screen/add_product/add_product.dart';
import 'package:ecommerce_app/screen/home/product_details.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/view/constants/images.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(
        context,
        listen: false,
      );
      productProvider.fetchProduct();
    });
    checkInternet();
    //
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isConnected = false;
        });
      } else {
        setState(() {
          isConnected = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 10),
            const Expanded(
              child: CustomTextfield(
                hintText: 'Explore Fashion',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(width: 7),
            CustomRoundButton(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: AddProduct(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 15),

        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    // Animated Container for cloths
                    Container(
                      height: 150,
                      width: 340,
                      decoration: BoxDecoration(
                        color: AppColor.premiumblackColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: AlignmentGeometry.bottomRight,
                        child: AppImages().whiteGuyImage,
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 32,
                      child: const CustomText(
                        text: 'Get your special \nsale upto 50%',
                        color: AppColor.whiteColor,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              if (!isConnected)
                const Expanded(
                  child: Center(
                    child: Text(
                      "Internet Not Connected",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                productProvider.isLoading
                    ? const Center(
                        child: LoadingAnimation(
                          loadingColor: AppColor.greenColor,
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          return OpenContainer(
                            transitionType: ContainerTransitionType.fadeThrough,
                            transitionDuration: const Duration(
                              milliseconds: 300,
                            ),
                            closedElevation: 4,
                            closedColor: Colors.white,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            openBuilder: (context, _) =>
                                ProductDetails(product: product),
                            closedBuilder: (context, openContainer) {
                              return GestureDetector(
                                onTap: openContainer, // start animation
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: product.images[0],
                                        height: 170,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child: LoadingAnimation(
                                                loadingColor:
                                                    AppColor.greenColor,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.broken_image,
                                              size: 170,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: product.title.toString(),
                                            color: AppColor.blackColor,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          CustomText(
                                            text:
                                                '\$${product.price.toString()}',
                                            color: AppColor.blackColor,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
            ],
          ),
        ),
      ],
    );
  }
}
