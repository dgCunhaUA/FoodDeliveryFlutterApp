import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';
import 'package:flutter_project/models/Item.dart';

class FoodMenuItem extends StatelessWidget {
  final info;
  const FoodMenuItem({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info["name"],
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                info["desc"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          InkWell(
            onTap: () => {
              context.read<CartBloc>().add(
                    AddItemToCart(
                      item: Item(
                        info["name"],
                        info["desc"],
                        info["price"],
                        info["img"],
                      ),
                    ),
                  ),
            },
            child: const Icon(
              Icons.add,
              color: Colors.green,
              size: 30.0,
            ),
          ),
          InkWell(
            onTap: () => {
              context.read<CartBloc>().add(
                    RemoveItemFromCart(
                      item: Item(
                        info["name"],
                        info["desc"],
                        info["price"],
                        info["img"],
                      ),
                    ),
                  ),
            },
            child: const Icon(
              Icons.minimize,
              color: Colors.green,
              size: 30.0,
            ),
          ),
          Image(
            image: AssetImage("images/${info["img"]}"),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
          ),
        ],
      ),
    );
  }
}
