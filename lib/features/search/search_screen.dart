import 'package:amazon_clone/features/search/widgets/search_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/global_variables.dart';
import '../../models/product.dart';
import '../admin/widgets/loader.dart';
import '../home/services/search_services.dart';
import '../home/widgets/address_box.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search-screen";
  final String query;
  const SearchScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isinit = false;
  List<Product>? searchProductList = [];
  late final _searchProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access the provider and perform actions
    if (!_isinit) {
      _searchProvider = Provider.of<SearchServices>(context, listen: true);
      _searchProvider.fetchAllProducts(context, widget.query);
      setState(() {
        _isinit = true;
      });
    }
  }

  void navigateTo() {}

  @override
  Widget build(BuildContext context) {
    searchProductList = _searchProvider.getProductList();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
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
        body: searchProductList == null
            ? const Loader()
            : Column(children: [
                const AddressBox(),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: searchProductList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SearchList(product: searchProductList![index]);
                  },
                )),
              ]));
  }
}
