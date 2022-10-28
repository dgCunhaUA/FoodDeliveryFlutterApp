import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';

class FoodMenuItem extends StatelessWidget {
  final info;
  const FoodMenuItem({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.info["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(
                      this.info["desc"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => {
                    context
                        .read<CartBloc>()
                        .add(AddItemToCart(item: this.info["name"]))
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 30.0,
                  ),
                ),
                Icon(
                  Icons.minimize,
                  color: Colors.green,
                  size: 30.0,
                ),
                Image(
                  image: AssetImage("images/" + this.info["img"]),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width / 4,
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
