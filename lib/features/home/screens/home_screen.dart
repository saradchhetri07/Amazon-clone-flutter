import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/home/widgets/corousel_image.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_day.dart';
import 'package:amazon_clone/features/home/widgets/top_categories.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constant/global_variables.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, "/search-screen", arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: const InputDecoration(
                            hintText: "Seach Amazon.in",
                            hintStyle: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                            contentPadding: EdgeInsets.only(top: 10),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.black38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0))),
                            prefixIcon: InkWell(
                              child: Padding(
                                padding: EdgeInsets.only(left: 6.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  color: Colors.transparent,
                  child: const Icon(Icons.mic),
                )
              ],
            ),
          )),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            SizedBox(
              height: 10.0,
            ),
            TopCategories(),
            CarouselImage(),
            DealOfDay()
          ],
        ),
      ),
    );
  }
}
