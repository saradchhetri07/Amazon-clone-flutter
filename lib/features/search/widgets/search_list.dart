import 'package:amazon_clone/constant/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/stars.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class SearchList extends StatefulWidget {
  final Product product;
  const SearchList({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  void navigateTo(Product product) {
    Navigator.pushNamed(context, "/product-details", arguments: product);
  }

  double averageRating = 0.0;
  double totalRating = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating = 0.0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (totalRating != 0) {
        averageRating = totalRating / widget.product.rating!.length;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(widget.product),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Image.network(
                  widget.product.images[0],
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
                        widget.product.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Stars(rating: averageRating)),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        '\$${widget.product.price}',
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
          )
        ],
      ),
    );
  }
}
