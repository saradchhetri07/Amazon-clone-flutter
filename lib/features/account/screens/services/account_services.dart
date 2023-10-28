import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../../constant/error_handling.dart';
import '../../../../constant/global_variables.dart';
import '../../../../constant/utils.dart';
import '../../../../models/order.dart';
import '../../../../providers/user_provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$newuri/api/order/getOrders"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                  //convert to order model
                  Order.fromJson(
                      //json to string
                      jsonEncode(
                          //toJson
                          jsonDecode(res.body)[i])));
            }
          });
      // print(jsonDecode(res.body));
    } catch (error) {
      showsnackBar(context, error.toString());
    }
    return orderList;
  }
}
