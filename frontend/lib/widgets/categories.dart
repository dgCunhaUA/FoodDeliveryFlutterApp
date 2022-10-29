import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/food_category.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FoodCategory(
                    title: "Restaurantes", cover: "restaurant_icon.png"),
                FoodCategory(title: "Mercearia", cover: "grocery_icon.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
