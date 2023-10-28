import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/auth/auth_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../account/screens/widgets/single_item.dart';
import '../widgets/loader.dart';
import './add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? productsList = [];
  bool _isinit = false;
  late final _productProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the provider and perform actions
    if (!_isinit) {
      _productProvider = Provider.of<Adminservices>(context, listen: true);
      _productProvider.fetchAllProducts(context);
      setState(() {
        _isinit = true;
      });
    }
  }

  void navigateTo() {
    Navigator.pushNamed(context, AddProduct.routeName);
  }

  @override
  Widget build(BuildContext context) {
    void deleteProduct(Product product, int index) {
      _productProvider.deleteProduct(context, product, index);
    }

    productsList = _productProvider.getProductList();
    return Scaffold(
      body: productsList == null
          ? const Loader()
          : GridView.builder(
              itemCount: productsList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = productsList![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleItem(imagelink: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                        IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: const Icon(Icons.delete_outline))
                      ],
                    )
                  ],
                );
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalVariables.selectedNavBarColor,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          navigateTo();
        },
        tooltip: 'Add a product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
