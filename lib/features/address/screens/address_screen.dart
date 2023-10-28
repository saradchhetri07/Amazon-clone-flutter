import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/providers/user_provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textField.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = "/address-screen";
  final String totalAmount;

  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  var addressToBeUsed = "";
  final _addressformkey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  List<PaymentItem> paymentItems = [];

  void onApplePaymentResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.setAddress(context, addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void paypressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    try {
      if (isForm == true && _addressformkey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else if (addressFromProvider.isNotEmpty) {
        addressToBeUsed = addressFromProvider;
      } else {
        showsnackBar(context, 'enter all values properly');
      }
    } catch (error) {
      throw Exception(error);
    }
    print(addressToBeUsed);

    // addressToBeUsed = "";

    // bool isForm = flatBuildingController.text.isNotEmpty ||
    //     areaController.text.isNotEmpty ||
    //     pincodeController.text.isNotEmpty ||
    //     cityController.text.isNotEmpty;

    // if (isForm) {
    //   if (_addressformkey.currentState!.validate()) {
    //     addressToBeUsed =
    //         '${flatBuildingController.text},${areaController.text},${pincodeController.text},${cityController.text}';
    //   } else {
    //     throw Exception('Please enter all the values');
    //   }
    //   if (addressFromProvider.isNotEmpty) {
    //     addressToBeUsed = addressFromProvider;
    //   } else {
    //     showsnackBar(context, "ERROR");
    //   }
    // }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    String address = userProvider.user.address;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
          )),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (addressToBeUsed.isNotEmpty)
                Container(
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Text(
                    addressToBeUsed,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'OR ',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Form(
                key: _addressformkey,
                child: Column(
                  children: [
                    CustomTextField(
                      customHintText: "Flat, House no, Building",
                      custom_controller: flatBuildingController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      customHintText: "Area, street",
                      custom_controller: areaController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      customHintText: "pincode",
                      custom_controller: pincodeController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      customHintText: "Town/city",
                      custom_controller: cityController,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ApplePayButton(
                  onPressed: () => paypressed(address),
                  width: double.infinity,
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  height: 50,
                  paymentConfigurationAsset: 'applepay.json',
                  onPaymentResult: onApplePaymentResult,
                  paymentItems: paymentItems)
            ],
          )),
    );
  }
}
