import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project/utils/restaurants_info.dart';
import 'package:flutter_project/widgets/menu_item.dart';

class RestaurantDetails extends StatelessWidget {
  final info;
  const RestaurantDetails({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage("images/" + this.info["img"]),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width / 1.67,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.info["name"],
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.black,
                            size: 16,
                          ),
                          Text(
                            this.info["stars"].toString() +
                                " (200+ classificações)" +
                                " • Hambúrgueres",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Escolhido para si",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ),
                            Column(
                              children: [
                                for (var info in food_menu)
                                  FoodMenuItem(info: info),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
