import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context).user;
    print(userprovider.name);
    return Container(
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: "Hello, ",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                      text: userprovider.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600))
                ]),
          ),
        ],
      ),
    );
  }
}
