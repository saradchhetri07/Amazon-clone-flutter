import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubTotal extends StatefulWidget {
  const SubTotal({super.key});

  @override
  State<SubTotal> createState() => _SubTotalState();
}

class _SubTotalState extends State<SubTotal> {
  @override
  Widget build(BuildContext context) {
    final userCartProvider = Provider.of<UserProvider>(context);
    int sum = 0;
    userCartProvider.user.cart
        .map((e) => sum = sum + e['product']['price'] * e['quantity'] as int)
        .toList();
    return Row(
      children: [
        Text(
          "SubTotal",
          style: TextStyle(fontSize: 26.0),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "\$${sum}",
          style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
