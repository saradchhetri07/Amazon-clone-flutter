import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:amazon_clone/features/auth/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/Category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/search_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

import 'features/address/screens/address_screen.dart';
import 'features/order_details/screens/order_details.dart';
import 'models/order.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => const BottomBar(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => const AddProduct(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const AdminScreen());
    case CategoryScreen.routeName:
      var category = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => CategoryScreen(category: category));
    case SearchScreen.routeName:
      var query = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => SearchScreen(query: query));
    case ProductDetails.routeName:
      var product = routesettings.arguments as Product;
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => ProductDetails(product: product));
    case AddressScreen.routeName:
      var totalAmount = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => AddressScreen(
                totalAmount: totalAmount,
              ));
    case OrderDetails.routeName:
      var order = routesettings.arguments as Order;
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => OrderDetails(
                order: order,
              ));
    default:
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen doesn't exist"),
                ),
              ));
  }
}
