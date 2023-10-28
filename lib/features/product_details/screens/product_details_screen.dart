import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constant/global_variables.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = "/product-details";
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double averageRating = 0.0;
  double myRating = 0.0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    double totalRating = 0.0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        setState(() {
          myRating = widget.product.rating![i].rating;
        });
      }
      if (totalRating != 0) {
        averageRating = totalRating / widget.product.rating!.length;
      }
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   double totalRating = 0.0;

  // }

  @override
  Widget build(BuildContext context) {
    final productDetailProviders =
        Provider.of<ProductDetailsServices>(context, listen: true);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Seach Amazon.in",
                            hintStyle: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                            contentPadding: EdgeInsets.only(top: 10),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            prefixIcon: InkWell(
                              child: Padding(
                                padding: EdgeInsets.only(left: 6.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.transparent,
                  child: const Icon(Icons.mic),
                )
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.product.id!),
                Stars(rating: averageRating),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
                alignment: Alignment.topLeft, child: Text(widget.product.name)),
            Container(
              width: double.maxFinite,
              child: CarouselSlider(
                  items: widget.product.images.map((item) {
                    return Builder(builder: (BuildContext context) {
                      return Image.network(
                        item,
                        fit: BoxFit.contain,
                        height: 200,
                      );
                    });
                  }).toList(),
                  options: CarouselOptions(viewportFraction: 1, height: 300)),
            ),
            Container(
              height: 5.0,
              color: Colors.black12,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Deal Price',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                      children: [
                        TextSpan(
                            text: ':\$ ${widget.product.price}',
                            style: TextStyle(color: Colors.red))
                      ]),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.topLeft,
              child: Text("${widget.product.description}"),
            ),
            Container(
              height: 5.0,
              color: Colors.black12,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: CustomButton(customText: "Buy Now", onTap: () {}),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: CustomButton(
                  buttoncolor: const Color.fromRGBO(254, 216, 19, 1),
                  customText: "Add to cart",
                  onTap: () async {
                    await productDetailProviders.addToCart(
                        context, widget.product);
                  }),
            ),
            Container(
              height: 5.0,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Rate this product",
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemBuilder: (context, _) {
                    return const Icon(Icons.star,
                        color: GlobalVariables.secondaryColor);
                  },
                  onRatingUpdate: (double value) async {
                    await productDetailProviders.rateProducts(
                        context, value, widget.product);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
