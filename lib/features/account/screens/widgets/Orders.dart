import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/account/screens/services/account_services.dart';
import 'package:amazon_clone/features/account/screens/widgets/single_item.dart';
import 'package:amazon_clone/features/order_details/screens/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../models/order.dart';
import '../../../admin/widgets/loader.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  Future<void> fetchOrder() async {
    orders = await accountServices.fetchMyOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Yours orders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 18,
                              color: GlobalVariables.selectedNavBarColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, OrderDetails.routeName,
                            arguments: orders![index]),
                        child: SingleItem(
                            imagelink: orders![index].products[0].images[0]),
                      );
                    }),
              )
            ],
          );
  }
}
