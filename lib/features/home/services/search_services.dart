import 'dart:convert';

import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constant/error_handling.dart';
import '../../../constant/global_variables.dart';
import '../../../constant/utils.dart';
import '../../../models/product.dart';

class SearchServices extends ChangeNotifier {
  List<Product> productList = [];

  List<Product> getProductList() {
    return productList;
  }

  Future<void> fetchAllProducts(
      BuildContext context, String searchQuery) async {
    productList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
          Uri.parse("$newuri/api/products/search/$searchQuery"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              notifyListeners();
            }
          });
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }
}
