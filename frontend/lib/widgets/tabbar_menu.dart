import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/client/profile/client_profile_screen.dart';
import 'package:flutter_project/screens/home_page.dart';
import 'package:flutter_project/screens/orders.dart';
import 'package:flutter_project/screens/search_screen.dart';
import 'package:flutter_project/screens/wallet.dart';
import 'package:flutter_project/screens/shopping_cart.dart';
import 'package:flutter_project/session_cubit.dart';
import 'package:flutter_project/session_state.dart';

import '../rider/profile/rider_profile_screen.dart';

class TabBarMenu extends StatefulWidget {
  const TabBarMenu({super.key});

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu> {
  //final bool driver_mode;
  int _selectedIndex = 0;

//divisão em três páginas, através de uma bottomNavigationBar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        List<Widget> widgetOptions = <Widget>[];
        var tabbarItem = <BottomNavigationBarItem>[];

        if (state is RiderAuthenticated) {
          widgetOptions = <Widget>[
            const Orders(),
            const Wallet(),
            const RiderProfileScreen()
          ];

          tabbarItem = <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining),
              label: 'Encomendas',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.wallet),
              label: 'Carteira',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Conta',
            ),
          ];
        }

        if (state is ClientAuthenticated) {
          widgetOptions = <Widget>[
            const HomePage(),
            SearchScreen(),
            const ShoppingCart(),
            const ClientProfileScreen()
          ];

          tabbarItem = <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Página Inicial',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.manage_search),
              label: 'Procurar',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Carrinhos',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Conta',
            ),
          ];
        }

        return Scaffold(
          body: widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            unselectedFontSize: 11.0,
            selectedFontSize: 11.0,
            type: BottomNavigationBarType.fixed,
            items: tabbarItem,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: const Color.fromARGB(255, 100, 100, 100),
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
