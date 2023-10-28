import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textField.dart';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _isLoading = true;
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final Adminservices adminservices = Adminservices();
  final _addProductFormKey = GlobalKey<FormState>();
  String category = 'Mobiles';

  List<File> images = [];

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void sellProduct() async {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      context.loaderOverlay.show();
      setState(() {
        _isLoading = context.loaderOverlay.visible;
      });
      await adminservices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);

      if (_isLoading) {
        context.loaderOverlay.hide();
        setState(() {
          _isLoading = context.loaderOverlay.visible;
        });
        Navigator.pushReplacementNamed(context, "/admin-screen");
      }
    }
  }

  void selectImage() async {
    var res = await pickImages();

    setState(() {
      images = res;
    });
  }

  Widget bodyWidget() => SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: selectImage,
                  child: images.isNotEmpty
                      ? Container(
                          width: double.maxFinite,
                          child: CarouselSlider(
                              items: images.map((item) {
                                return Builder(builder: (BuildContext context) {
                                  return Image.file(
                                    item,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  );
                                });
                              }).toList(),
                              options: CarouselOptions(
                                  viewportFraction: 1, height: 200)),
                        )
                      : DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10.0),
                          dashPattern: const [10, 4],
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                Text(
                                  "Select Product Image",
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(1.0)),
                                )
                              ],
                            ),
                          )),
                ),
                SizedBox(height: 10.0),
                CustomTextField(
                  customHintText: "Name your product",
                  custom_controller: productNameController,
                ),
                SizedBox(height: 10.0),
                CustomTextField(
                  customHintText: "Description of your product",
                  custom_controller: descriptionController,
                  maxLines: 7,
                ),
                SizedBox(height: 10.0),
                CustomTextField(
                    customHintText: "price of product",
                    custom_controller: priceController),
                SizedBox(height: 10.0),
                CustomTextField(
                    customHintText: "How many?",
                    custom_controller: quantityController),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newval) {
                      setState(() {
                        category = newval!;
                      });
                    },
                  ),
                ),
                CustomButton(
                    customText: "Submit",
                    onTap: () {
                      sellProduct();
                    })
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: getAppBar(), body: bodyWidget());
  }
}
