import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      address: '',
      email: '',
      id: '',
      name: '',
      password: '',
      token: '',
      type: '',
      cart: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    print("user $_user");
    notifyListeners();
  }

  void setUserFromModel(User newuser) {
    _user = newuser;
    notifyListeners();
  }

  void addCartToUser(User newuser) {
    _user = newuser;
    notifyListeners();
  }
}
