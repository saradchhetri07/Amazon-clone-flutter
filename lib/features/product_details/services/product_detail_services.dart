import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constant/error_handling.dart';
import '../../../constant/global_variables.dart';
import '../../../constant/utils.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices extends ChangeNotifier {
  Future<void> rateProducts(
      BuildContext context, double rating, Product product) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
          Uri.parse("$newuri/api/rate-products"),
          body: jsonEncode({'id': product.id!, 'rating': rating}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });

      print(jsonDecode(res.body));
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }

  Future<void> addToCart(BuildContext context, Product product) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$newuri/api/add-to-cart"),
          body: jsonEncode({'id': product.id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });
      print(jsonDecode(res.body));
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.addCartToUser(user);
            notifyListeners();
            showsnackBar(context, 'Product added to cart');
          });
      // print(jsonDecode(res.body));
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }
}
