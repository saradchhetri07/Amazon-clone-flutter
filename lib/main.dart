import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/auth/auth_screen.dart';
import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/services/product_detail_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'features/home/services/home_services.dart';
import 'features/home/services/search_services.dart';
import 'features/product_details/screens/product_details_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => Adminservices()),
    ChangeNotifierProvider(create: (context) => ProductServices()),
    ChangeNotifierProvider(create: (context) => SearchServices()),
    ChangeNotifierProvider(create: (context) => ProductDetailsServices()),
    ChangeNotifierProvider(create: (context) => CartServices()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = new AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
          child: SpinKitSquareCircle(
        color: Colors.white,
        size: 50.0,
      )),
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      // duration: Duration(seconds: 2),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            appBarTheme: const AppBarTheme(
                elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
            colorScheme: const ColorScheme.light(
                primary: GlobalVariables.secondaryColor),
            useMaterial3: true,
          ),
          //custom routes
          onGenerateRoute: (settings) => generateRoute(settings),

          // routes: {HomeScreen.routeName: (context) => HomeScreen()},
          home: Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? Provider.of<UserProvider>(context).user.type == 'user'
                  ? const BottomBar()
                  : const AdminScreen()
              : const AuthScreen()),
    );
  }
}
