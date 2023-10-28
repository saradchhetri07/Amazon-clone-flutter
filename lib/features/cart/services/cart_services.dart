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

class CartServices with ChangeNotifier {
  Future<void> removeCart(BuildContext context, Product product) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
          Uri.parse("$newuri/api/delete-from-cart"),
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
            showsnackBar(context, 'Product deleted from cart ');
          });
      // print(jsonDecode(res.body));
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }
}
