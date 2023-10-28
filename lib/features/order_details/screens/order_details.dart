import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constant/global_variables.dart';
import '../../../models/order.dart';
import '../../../providers/user_provider.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = "/order-details";
  final Order order;
  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentSteps = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentSteps = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    int status = widget.order.status;
    Adminservices adminservices = Adminservices();
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
                        //onFieldSubmitted: navigateToSearchScreen,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 30.0,
              child: const Text(
                "View Order Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.black12),
                  borderRadius: BorderRadius.circular(5)),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(children: [
                    Container(
                      height: 25.0,
                      width: double.maxFinite,
                      child: Text(
                          "Order Date: ${DateFormat.yMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderAt))}"),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 25.0,
                      width: double.maxFinite,
                      child: Text("Order Id: ${widget.order.id.toString()}"),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      height: 25.0,
                      width: double.maxFinite,
                      child: Text("Order Total: \$${widget.order.totalPrice}"),
                    ),
                  ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30.0,
              child: const Text(
                "Purchase details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.black12),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: 100,
                      child: Image.network(
                        '${widget.order.products[0].images[0]}', // Replace with your image URL
                        fit: BoxFit.cover, // Set the fit property
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Container(
                        height: double.maxFinite,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.order.products[0].name}",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "qty:${widget.order.products[0].quantity}",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w200),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 30.0,
              child: const Text(
                "Tracking",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5, color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stepper(
                                controlsBuilder: (context, details) {
                                  if (user.type == 'admin') {
                                    return CustomButton(
                                        customText: 'Done',
                                        onTap: () async {
                                          setState(() {
                                            currentSteps =
                                                details.currentStep + 1;
                                          });
                                          await adminservices.changeStatus(
                                              context: context,
                                              status: currentSteps,
                                              orderId:
                                                  widget.order.id.toString());
                                        });
                                  }
                                  return const SizedBox();
                                },
                                currentStep: currentSteps,
                                steps: [
                                  Step(
                                    isActive: currentSteps >= 0,
                                    state: currentSteps >= 0
                                        ? StepState.complete
                                        : StepState.indexed,
                                    title: Text('Pending'),
                                    content: Text(
                                        'Your order is yet to be delivered'),
                                  ),
                                  Step(
                                      state: currentSteps >= 1
                                          ? StepState.complete
                                          : StepState.indexed,
                                      isActive: currentSteps >= 1,
                                      title: Text('Completed'),
                                      content: Text(
                                          'Your order has been delivered,you are yet to sign in')),
                                  Step(
                                      state: currentSteps >= 2
                                          ? StepState.complete
                                          : StepState.indexed,
                                      isActive: currentSteps >= 2,
                                      title: Text('Received'),
                                      content: Text(
                                          'Your order has been delivered and signed by you')),
                                  Step(
                                      state: currentSteps >= 3
                                          ? StepState.complete
                                          : StepState.indexed,
                                      isActive: currentSteps >= 3,
                                      title: Text('Delivered'),
                                      content: Text(
                                          'Your order has been delivered and signed by you')),
                                ])
                            // Container(
                            //   height: 30,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         height: 30,
                            //         width: 30,
                            //         decoration: BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             color: status == 0
                            //                 ? GlobalVariables.secondaryColor
                            //                 : Colors.black26),
                            //         child: Icon(
                            //           Icons.check_outlined,
                            //           color: Colors.white,
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           height: 30,
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, top: 5.0),
                            //             child: const Text(
                            //               "Pending",
                            //               style: TextStyle(fontSize: 15.0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5.0,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         height: 80,
                            //         width: 2,
                            //         decoration: BoxDecoration(
                            //           color: Colors.black38,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5.0,
                            // ),
                            // Container(
                            //   height: 30,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         height: 30,
                            //         width: 30,
                            //         decoration: BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             color: status == 1
                            //                 ? GlobalVariables.secondaryColor
                            //                 : Colors.black26),
                            //         child: status == 1
                            //             ? Icon(
                            //                 Icons.check_outlined,
                            //                 color: Colors.white,
                            //               )
                            //             : Center(
                            //                 child: Text(
                            //                 "1",
                            //                 style:
                            //                     TextStyle(color: Colors.white),
                            //               )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           height: 30,
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, top: 5.0),
                            //             child: const Text(
                            //               "Completed",
                            //               style: TextStyle(fontSize: 15.0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5.0,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         height: 80,
                            //         width: 2.0,
                            //         decoration: BoxDecoration(
                            //           color: Colors.black38,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 5.0,
                            // ),
                            // Container(
                            //   height: 30,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         height: 30,
                            //         width: 30,
                            //         decoration: BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             color: status == 2
                            //                 ? GlobalVariables.secondaryColor
                            //                 : Colors.black26),
                            //         child: status == 2
                            //             ? Icon(
                            //                 Icons.check_outlined,
                            //                 color: Colors.white,
                            //               )
                            //             : Center(
                            //                 child: Text(
                            //                 "2",
                            //                 style:
                            //                     TextStyle(color: Colors.white),
                            //               )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           height: 30,
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, top: 5.0),
                            //             child: const Text(
                            //               "received",
                            //               style: TextStyle(fontSize: 15.0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         height: 80,
                            //         width: 2.0,
                            //         decoration: BoxDecoration(
                            //           color: Colors.black38,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 5.0,
                            // ),
                            // Container(
                            //   height: 30,
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Container(
                            //         height: 30,
                            //         width: 30,
                            //         decoration: BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             color: status == 2
                            //                 ? GlobalVariables.secondaryColor
                            //                 : Colors.black26),
                            //         child: status == 3
                            //             ? Icon(
                            //                 Icons.check_outlined,
                            //                 color: Colors.white,
                            //               )
                            //             : Center(
                            //                 child: Text(
                            //                 "3",
                            //                 style:
                            //                     TextStyle(color: Colors.white),
                            //               )),
                            //       ),
                            //       Expanded(
                            //         child: Container(
                            //           height: 30,
                            //           child: Padding(
                            //             padding: const EdgeInsets.only(
                            //                 left: 8.0, top: 5.0),
                            //             child: const Text(
                            //               "delivered",
                            //               style: TextStyle(fontSize: 15.0),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
