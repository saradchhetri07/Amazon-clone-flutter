import 'package:amazon_clone/constant/global_variables.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_day.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  navigateTo(BuildContext context, String category) {
    Navigator.pushNamed(context, "/category-screen", arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemExtent: 75,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigateTo(
                  context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          GlobalVariables.categoryImages[index]['image']!,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      )),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
