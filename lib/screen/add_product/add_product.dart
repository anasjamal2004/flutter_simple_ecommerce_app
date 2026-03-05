import 'dart:io';
import 'package:ecommerce_app/data/services/supabase_services.dart';
import 'package:ecommerce_app/providers/signin_provider.dart';
import 'package:ecommerce_app/view/constants/app_color.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_button.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_text.dart';
import 'package:ecommerce_app/widgets/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late TextEditingController titleController;
  late TextEditingController priceController;
  late TextEditingController descController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    descController = TextEditingController();
  }

  // Image Picker
  List<File>? _selectedImage;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage(
      imageQuality: 80,
    );

    if (pickedFiles != null) {
      setState(() {
        _selectedImage = pickedFiles
            .take(3)
            .map((images) => File(images.path))
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least 3 images.")),
      );
    }
  }

  void removeImage(int index) {
    setState(() {
      if (_selectedImage != null &&
          index >= 0 &&
          index < _selectedImage!.length) {
        _selectedImage!.removeAt(index);

        if (currentIndex >= _selectedImage!.length &&
            _selectedImage!.isNotEmpty) {
          currentIndex = _selectedImage!.length - 1;
        }

        if (_selectedImage!.isEmpty) {
          _selectedImage = null;
        }
      }
    });
  }

  void addProduct() async {
    try {
      if (_selectedImage != null &&
          titleController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          descController.text.isNotEmpty) {
        await SupabaseServices().saveProduct(
          title: titleController.text,
          description: descController.text,
          price: priceController.text,
          images: _selectedImage!,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Kindly Upload the images and fill the fields"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      throw Exception('Product is not uploaded: $error');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.whiteColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage![currentIndex],
                            fit: BoxFit.scaleDown,
                          )
                        : Icon(
                            Icons.image,
                            size: 50,
                            color: AppColor.blackColor.withValues(alpha: 0.3),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: _selectedImage != null
                    ? Align(
                        alignment: AlignmentGeometry.topCenter,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImage!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: currentIndex == index
                                        ? AppColor.greenColor
                                        : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: Badge(
                                  alignment: Alignment.topRight,
                                  largeSize: 20,
                                  label: GestureDetector(
                                    onTap: () {
                                      removeImage(index);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                    child: Image.file(
                                      _selectedImage![index],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: const CustomText(
                          text: 'No image selected!',
                          color: AppColor.blackColor,
                        ),
                      ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTextfield(
                      hintText: 'Product title',
                      controller: titleController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    CustomTextfield(
                      hintText: 'Product price',
                      controller: priceController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    CustomTextfield(
                      hintText: 'Product description',
                      controller: descController,
                      keyboardType: TextInputType.text,
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<ProductUpload>(
                  builder: (context, provider, child) {
                    return CustomButton(
                      loadingColor: AppColor.whiteColor,
                      isLoading: provider.isLoading,
                      width: double.infinity,
                      text: 'Add Product',
                      onTap: () {
                        provider.uploadProduct(context, addProduct);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
