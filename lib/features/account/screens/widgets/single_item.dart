import 'package:flutter/material.dart';

class SingleItem extends StatefulWidget {
  final String? imagelink;
  const SingleItem({
    Key? key,
    this.imagelink,
  }) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.5, color: Colors.black12),
            borderRadius: BorderRadius.circular(5)),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(10.0),
          child: Image.network(
            widget.imagelink!,
            width: 180,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
