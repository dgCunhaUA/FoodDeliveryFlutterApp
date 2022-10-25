import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final info;
  const RestaurantCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage("images/" + this.info["img"]),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / 2.4,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                this.info["name"],
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(this.info["stars"].toString()),
                ],
              ),
            ],
          )),
          Text(
            "Taxa de €" +
                this.info["fee"].toString() +
                " • " +
                this.info["time_distance"][0].toString() +
                "-" +
                this.info["time_distance"][1].toString() +
                " min",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
