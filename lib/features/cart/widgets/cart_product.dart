import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/stars.dart';
import '../../../models/product.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    final productDetailProvider =
        Provider.of<ProductDetailsServices>(context, listen: true);
    final cartProvider = Provider.of<CartServices>(context, listen: true);

    void decreaseQuantity(Product product) {
      cartProvider.removeCart(context, product);
    }

    void increaseQuantity(Product product) {
      productDetailProvider.addToCart(context, product);
    }

    final productProvider =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    final product = Product.fromMap(productProvider['product']);
    final quantity = productProvider['quantity'];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitWidth,
                width: 135,
                height: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'eligible for FREE SHIPPING',
                      style: TextStyle(fontSize: 16.0),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'IN STOCK',
                      style: TextStyle(fontSize: 12.0, color: Colors.cyan),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => increaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 32,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1.5),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    alignment: Alignment.center,
                    child: Text("${quantity}"),
                  ),
                  InkWell(
                    onTap: () => decreaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(Icons.remove),
                    ),
                  )
                ],
              ),
            )
          ]),
        )
      ],
    );
  }
}
