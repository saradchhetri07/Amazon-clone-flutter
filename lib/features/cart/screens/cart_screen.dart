import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/global_variables.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final userCartProvider = Provider.of<UserProvider>(context);
    int sum = 0;
    userCartProvider.user.cart
        .map((e) => sum = sum + e['product']['price'] * e['quantity'] as int)
        .toList();
    final userProvider = Provider.of<UserProvider>(context);
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
                        // onFieldSubmitted: navigateToSearchScreen,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AddressBox(),
            SubTotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                  customText:
                      "Proceed to buy ${userProvider.user.cart.length} items",
                  buttoncolor: const Color.fromARGB(255, 201, 133, 31),
                  onTap: () {
                    Navigator.pushNamed(context, "/address-screen",
                        arguments: sum.toString());
                  }),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1.0,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: userProvider.user.cart.length,
                itemBuilder: ((context, index) {
                  return CartProduct(index: index);
                }))
          ],
        ),
      ),
    );
  }
}
