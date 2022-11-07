import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';
import 'package:flutter_project/models/Item.dart';

class FoodMenuItem extends StatelessWidget {
  final info;
  final menu;

  const FoodMenuItem({
    super.key,
    required this.info,
    required this.menu,
  });

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
                menu["name"],
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Text(
                menu["desc"],
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
                        menu["name"],
                        menu["desc"],
                        menu["price"],
                        menu["img"],
                      ),
                      restaurant: info["name"],
                      address: info["address"],
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
                        menu["name"],
                        menu["desc"],
                        menu["price"],
                        menu["img"],
                      ),
                      restaurant: info["name"],
                      address: info["address"],
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
            image: AssetImage("images/${menu["img"]}"),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
          ),
        ],
      ),
    );
  }
}
