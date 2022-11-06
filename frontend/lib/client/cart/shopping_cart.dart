import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';
import 'package:flutter_project/client/cart/cart_manage_status.dart';
import 'package:flutter_project/client/orders/client_orders_view.dart';
import 'package:flutter_project/client/orders/orders_bloc.dart';
import 'package:flutter_project/screens/loading.dart';
import 'package:flutter_project/screens/orders.dart';
import 'package:flutter_project/utils/restaurants_info.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Carrinho'),
              trailing: ElevatedButton.icon(
                onPressed: () => {
                  context.read<OrdersBloc>().add(FectingOrders()),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientOrdersView(),
                    ),
                  ),
                },
                icon: const Icon(Icons.book, size: 16),
                label: const Text("Pedidos"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                    foregroundColor: Colors.black //<-- SEE HERE
                    ),
              ),
            )
          ];
        },
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.cartStatus == CartStatus.empty) {
              return _cartEmpty();
            } else if (state.cartManageStatus is CartSubmitting) {
              return const LoadingScreen();
            } else {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.items[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    state.items[index].desc,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () => {
                                  context.read<CartBloc>().add(
                                        RemoveItemFromCart(
                                          item: state.items[index],
                                          restaurant: state.restaurant,
                                          address: state.address,
                                        ),
                                      ),
                                  if (state.cartManageStatus
                                      is CartRemoveSuccess)
                                    {
                                      _showSnackBar(context,
                                          "Removido com sucesso", Colors.green),
                                    }
                                  else if (state.cartManageStatus
                                      is CartRemoveFailed)
                                    {
                                      _showSnackBar(context, "Erro ao remover",
                                          Colors.red),
                                    }
                                },
                                child: const Icon(
                                  Icons.minimize,
                                  color: Colors.green,
                                  size: 30.0,
                                ),
                              ),
                              Image(
                                image: AssetImage(
                                    "images/${state.items[index].img}"),
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.width / 4,
                                width: MediaQuery.of(context).size.width / 4,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.read<CartBloc>().add(
                                SubmitCart(),
                              );
                          if (state.cartManageStatus is CartSubmitSuccess) {
                            _showSnackBar(
                                context,
                                "Pedido encomendado com sucesso ",
                                Colors.green);
                          } else if (state.cartManageStatus
                              is CartSubmitFailed) {
                            _showSnackBar(context, "Erro ao encomendar pedido",
                                Colors.red);
                          }
                        },
                        icon: const Icon(Icons.chevron_left),
                        label: const Text(
                          "Encomendar",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 70),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _cartEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Image(
            image: AssetImage("images/cart.png"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Adicione artigos para iniciar \n um carrinho',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
            'Assim que adicionar artigos de um restaurante ou estabelecimento, o seu carrinho será apresentado aqui.',
            textAlign: TextAlign.center,
          ),
        ),
      ],
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
