import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CrossRestaurantCard extends StatelessWidget {
  final info;
  const CrossRestaurantCard({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network("images/" + this.info["img"],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width / 2.5,
                width: MediaQuery.of(context).size.width / 1.6),
          ),
          Text(
            this.info["name"],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
