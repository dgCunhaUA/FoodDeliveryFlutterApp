import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';
import 'package:flutter_project/client/cart/cart_manage_status.dart';
import 'package:flutter_project/utils/restaurants_info.dart';
import 'package:flutter_project/widgets/menu_item.dart';

class RestaurantDetails extends StatelessWidget {
  final info;
  const RestaurantDetails({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state.cartManageStatus is CartRemoveSuccess) {
            _showSnackBar(context, "Removido com sucesso", Colors.green);
          } else if (state.cartManageStatus is CartRemoveFailed) {
            _showSnackBar(context, "Erro ao remover", Colors.red);
          } else if (state.cartManageStatus is CartAddSuccess) {
            _showSnackBar(context, "Adicionado com sucesso", Colors.green);
          } else if (state.cartManageStatus is CartAddFailed) {
            _showSnackBar(context, "Erro ao adicionar", Colors.red);
          }
        },
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage("images/" + info["img"]),
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width / 1.67,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info["name"],
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.black,
                            size: 16,
                          ),
                          Text(
                            "${info["stars"]} (200+ classificações) • Hambúrgueres",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Escolhido para si",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                            ),
                            Column(
                              children: [
                                for (var menu in info["menu"])
                                  FoodMenuItem(
                                    info: info,
                                    menu: menu,
                                  ),
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

  void _showSnackBar(BuildContext context, String message, Color color) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
