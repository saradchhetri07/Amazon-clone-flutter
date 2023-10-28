import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/global_variables.dart';
import '../../../models/product.dart';
import '../services/home_services.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/category-screen";
  final String category;
  const CategoryScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isinit = false;
  List<Product>? productList = [];
  late final _productProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the provider and perform actions
    if (!_isinit) {
      _productProvider = Provider.of<ProductServices>(context, listen: true);
      _productProvider.fetchAllProducts(context, widget.category);
      setState(() {
        _isinit = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    productList = _productProvider.getProductList();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
              ),
              title: Container(
                alignment: Alignment.center,
                child: const Text("Essentials"),
              ))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shopping for ${widget.category}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
                itemCount: productList!.length,
                padding: const EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final product = productList![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black12, width: 0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              product.images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                            const EdgeInsets.only(left: 0, top: 0, right: 15),
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
