import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';

class Adminservices extends ChangeNotifier {
  List<Product> productList = [];

  List<Product> getProductList() {
    return productList;
  }

  Future<void> sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      BuildContext newcontext = context;
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      List<String> imageUrls = [];
      final cloudinary = CloudinaryPublic('dihhzktkb', 'pmso1ie7');
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
        rating: [],
      );

      http.Response res = await http.post(
          Uri.parse("$newuri/admin/add-product"),
          body: product.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });

      httpErrorHandle(
          response: res,
          context: newcontext,
          onSucess: () {
            productList.add(product);
            notifyListeners();
            showsnackBar(context, 'Product added successfully');
          });
    } catch (e) {
      showsnackBar(context, e.toString());
      print(e.toString());
    }
  }

  Future<void> fetchAllProducts(BuildContext context) async {
    productList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
          Uri.parse("$newuri/admin/get-products"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });

      // for (int i = 0; i < jsonDecode(res.body).length; i++) {
      //   productList.add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
      // }
      // print("new product list $productList");
      // notifyListeners();
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

  Future<void> changeStatus({
    required BuildContext context,
    required int status,
    required String orderId,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      print("${status}");
      print("${orderId}");
      http.Response res = await http.post(
          Uri.parse("$newuri/admin/change-status"),
          body: jsonEncode({'status': status, 'orderId': orderId}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            showsnackBar(context, "status changed");
          });
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    List<Order> orderList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http
          .get(Uri.parse("$newuri/admin/get-orders"), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': userProvider.user.token
      });
      print(jsonDecode(res.body));

      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList
                  .add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
              notifyListeners();
            }
          });
    } catch (error) {
      showsnackBar(context, error.toString());
    }
    return orderList;
  }

  void deleteProduct(BuildContext context, Product product, int index) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse("$newuri/admin/delete-product"),
          body: jsonEncode({'_id': product.id}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': userProvider.user.token
          });
      productList.removeAt(index);

      notifyListeners();
      // httpErrorHandle(
      //     index: index,
      //     response: res,
      //     context: context,
      //     onSucess: () {
      //       productList.removeAt(index);
      //       notifyListeners();
      //     });
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarnings = 0;
    try {
      http.Response res = await http
          .get(Uri.parse("$newuri/admin/analytics"), headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-auth-token': userProvider.user.token
      });
      print(jsonDecode(res.body));

      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            var response = jsonDecode(res.body);
            totalEarnings = response['totalEarnings'];
            sales = [
              Sales('Mobiles', response['mobileCategories']),
              Sales('Essentials', response['EssentialsCategories']),
              Sales('Appliances', response['AppliancesCategories']),
              Sales('Books', response['BooksCategories']),
              Sales("Fashion", response['FashionCategories'])
            ];
          });
    } catch (error) {
      showsnackBar(context, error.toString());
    }
    return {'sales': sales, 'totalEarnings': totalEarnings};
  }
}
