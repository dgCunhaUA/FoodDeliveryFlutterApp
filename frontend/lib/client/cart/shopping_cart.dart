import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/cart/cart_bloc.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        print(state.cartStatus);
        print(state.items);

        return Text("data");
      },
    );
  }
}

    /* return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Carrinhos'),
              trailing: ElevatedButton.icon(
                onPressed: () {},
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
        body: BlocProvider(
          create: (context) => CartBloc(),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              print(state.cartStatus);
              print(state.items);

              if (state.cartStatus == CartStatus.empty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Image(
                        image: AssetImage("images/cart.png"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Adicione artigos para iniciar \n um carrinho',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Assim que adicionar artigos de um restaurante ou estabelecimento, o seu carrinho será apresentado aqui.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          //TODO: BUG
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TabBarMenu(),
                            ),
                          ); */
                        },
                        child: const Text("Faça Compras (bug)")),
                  ],
                );
              } else {
                return Text("ola");
              }
            },
          ),
        ),
      ),
    ); 
  }
}*/
