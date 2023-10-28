import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/features/account/screens/widgets/below_appbar.dart';
import 'package:amazon_clone/features/account/screens/widgets/top_button.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 120,
                    height: 45,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.search),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
      body: Column(
        children: [BelowAppBar(), SizedBox(height: 10), TopButton()],
      ),
    );
  }
}
