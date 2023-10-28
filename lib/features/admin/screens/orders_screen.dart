import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/loader.dart';
import 'package:amazon_clone/features/order_details/screens/order_details.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';
import '../../account/screens/widgets/single_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Adminservices adminservices = Adminservices();
  List<Order>? orderList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  Future<void> fetchOrder() async {
    orderList = await adminservices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Loader()
        : GridView.builder(
            itemCount: orderList!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetails.routeName,
                      arguments: orderList![index]);
                },
                child: SizedBox(
                    height: 140,
                    child: SingleItem(
                        imagelink: orderList![index].products[0].images[0])),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
  }
}
