import 'package:amazon_clone/constant/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: CarouselSlider(
          items: GlobalVariables.carouselImages.map((item) {
            return Builder(builder: (BuildContext context) {
              return Image.network(
                item,
                fit: BoxFit.cover,
                height: 200,
              );
            });
          }).toList(),
          options: CarouselOptions(viewportFraction: 1, height: 200)),
    );
  }
}
