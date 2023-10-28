import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constant/error_handling.dart';
import '../../../constant/global_variables.dart';
import '../../../constant/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AddressServices {
  Future<void> setAddress(BuildContext context, String address) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$newuri/api/save-address"),
          body: jsonEncode({'address': address}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });
      print("response from servers is ${jsonDecode(res.body)}");
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)['address']);
            userProvider.addCartToUser(user);
            showsnackBar(context, 'address added');
          });
      // print(jsonDecode(res.body));
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    print("came here");
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      print("user carts are of length ${userProvider.user.cart.length}");
      http.Response res = await http.post(Uri.parse("$newuri/api/order"),
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'totalPrice': totalSum,
            'address': address
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });
      print(res);
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            showsnackBar(context, 'Your order has been placed');
            User user = userProvider.user.copyWith(cart: []);

            userProvider.setUserFromModel(user);
            showsnackBar(context, 'address added');
          });
      // print(jsonDecode(res.body));
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }
}
