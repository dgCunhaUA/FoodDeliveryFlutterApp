import 'package:flutter/material.dart';
import 'package:flutter_project/screens/account.dart';
import 'package:flutter_project/screens/home_page.dart';
import 'package:flutter_project/screens/orders.dart';
import 'package:flutter_project/screens/wallet.dart';
import 'package:flutter_project/screens/shopping_cart.dart';
import 'package:flutter_project/utils/mode.dart';

class TabBarMenu extends StatefulWidget {
  const TabBarMenu({super.key});

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu> {
  int _selectedIndex = 0;

  //divisão em três páginas, através de uma bottomNavigationBar
  static const List<Widget> _widgetOptions = driver_mode
      ? <Widget>[Orders(), Wallet()]
      : <Widget>[HomePage(), ShoppingCart(), Account()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var tabbar_item = driver_mode
      ? const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.delivery_dining),
            label: 'Encomendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Carteira',
          ),
        ]
      : const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Página Inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinhos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Conta',
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedFontSize: 11.0,
        selectedFontSize: 11.0,
        type: BottomNavigationBarType.fixed,
        items: tabbar_item,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 100, 100, 100),
        onTap: _onItemTapped,
      ),
    );
  }
}
