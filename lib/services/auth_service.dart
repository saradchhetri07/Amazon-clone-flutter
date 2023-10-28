import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "../constant/global_variables.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../features/auth/auth_screen.dart';

class AuthService {
  //sign Up user
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String username,
      required String password}) async {
    try {
      User user = User(
          id: '',
          name: username,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: []);
      http.Response res = await http.post(Uri.parse('$newuri/api/signUp'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            showsnackBar(context,
                'Account has been created. Login with the same credentials');
          });
    } catch (error) {
      showsnackBar(context, error.toString());
    }
  }

  Future<void> signInUser(
      {required BuildContext ctx,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$newuri/api/signIn'),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8'
          });
      httpErrorHandle(
          response: res,
          context: ctx,
          onSucess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            Provider.of<UserProvider>(ctx, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushReplacementNamed(ctx, BottomBar.routeName);
          });
    } catch (error) {
      showsnackBar(ctx, error.toString());
    }
  }

  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$newuri/isValidToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response) {
        //get user data
        http.Response userRes = await http.get(Uri.parse("$newuri/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setUser(userRes.body);
      }
    } on SocketException catch (e) {
      print(e.message);
    } catch (error) {
      print(error);
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    print("came here");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('x-auth-token', '');
    Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }
}
