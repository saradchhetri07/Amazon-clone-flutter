import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String orderText;
  final VoidCallback onPressed;
  const AccountButton({required this.orderText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.0),
            color: Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
                elevation: 2.0,
                side: BorderSide(color: Colors.grey, width: 1.0),
                primary: Colors.black12.withOpacity(0.03),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: onPressed,
            child: Text(
              orderText,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            )),
      ),
    );
  }
}
