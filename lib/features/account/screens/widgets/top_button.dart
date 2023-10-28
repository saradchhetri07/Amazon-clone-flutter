import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/features/account/screens/services/account_services.dart';
import 'package:amazon_clone/features/account/screens/widgets/Orders.dart';
import 'package:amazon_clone/features/account/screens/widgets/account_button.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              orderText: "Yours orders",
              onPressed: () {},
            ),
            AccountButton(
              orderText: "Turn Seller",
              onPressed: () {},
            )
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            AccountButton(
              orderText: "Sign Out",
              onPressed: () {
                print("came here 1");
                AuthService().logOutUser(context);
              },
            ),
            AccountButton(
              orderText: "Your wishlist",
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Orders()
      ],
    );
  }
}
