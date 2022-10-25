import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/screens/home_page.dart';
import 'package:flutter_project/widgets/tabbar_menu.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Carrinhos'),
              trailing: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.book, size: 16),
                  label: Text("Pedidos"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 236, 236, 236),
                      foregroundColor: Colors.black //<-- SEE HERE
                      )),
            )
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Image(image: AssetImage("images/cart.png")),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Adicione artigos para iniciar \n um carrinho',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Assim que adicionar artigos de um restaurante ou estabelecimento, o seu carrinho será apresentado aqui.',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TabBarMenu()),
                  );
                },
                child: Text("Faça Compras")),
          ],
        ),
      ),
    );
  }
}
